local spawnRegions = SpawnRegionMgr.getSpawnRegionsAux()

local rarities = {0,1,5,15,30,60,100}

function doTelecorn()
    if SandboxVars.Telecorn.Rarity == 1 then return end
    if not SandboxVars.Telecorn.Rarity == 7 then
        if ZombRand(1, 101) > rarities[SandboxVars.Telecorn.Rarity] then return end
    end

    local region = spawnRegions[ZombRand(1, #spawnRegions+1)]
    local spawnpointMap = {}
    for _,spawnpoints in pairs(region.points) do
        table.insert(spawnpointMap, spawnpoints)
    end
    local points = spawnpointMap[ZombRand(1, #spawnpointMap+1)]
    local spawnpoint = points[ZombRand(1, #points+1)]
    
    local x = (spawnpoint.worldX * 300) + spawnpoint.posX
    local y = (spawnpoint.worldY * 300) + spawnpoint.posY

    getPlayer():setX(x)
    getPlayer():setY(y)
    getPlayer():setZ(spawnpoint.posZ)

    getPlayer():setLx(x)
    getPlayer():setLy(y)
    getPlayer():setLz(spawnpoint.posZ)
    Events.OnTick.Remove(doTelecorn)
end

local old_perform = ISEatFoodAction.perform
function ISEatFoodAction:perform()
    if self.item:getType() == 'Corn' or self.item:getType() ==  'CannedCornOpen' or self.item:getType() == 'CornFrozen' then
        Events.OnTick.Add(doTelecorn)
    end
    old_perform(self)
end