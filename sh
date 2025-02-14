local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local DataKey = "NotSameServers.json"

-- Убираем зависимость от Synapse X
pcall(function()
    TeleportService:SetTeleportSetting("ServerHopData", {LastHour = actualHour})
end)

-- Загружаем историю серверов
local function LoadServerData()
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(DataKey))
    end)
    
    if success and type(data) == "table" then
        AllIDs = data
    else
        AllIDs = {actualHour}
        writefile(DataKey, HttpService:JSONEncode(AllIDs))
    end
end

LoadServerData()

local function TPReturner()
    local url = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
    if foundAnything ~= "" then
        url = url .. "&cursor=" .. foundAnything
    end
    
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if not success or not response or not response.data then return end

    if response.nextPageCursor then
        foundAnything = response.nextPageCursor
    end

    for _, v in ipairs(response.data) do
        local ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            if not table.find(AllIDs, ID) then
                table.insert(AllIDs, ID)
                writefile(DataKey, HttpService:JSONEncode(AllIDs))
                
                task.wait()
                TeleportService:TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                task.wait(4)
                return
            end
        end
    end
end

local function TeleportLoop()
    while task.wait(1) do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

TeleportLoop()

