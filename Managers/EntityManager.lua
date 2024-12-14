--<====== Classe permettant de gérer toute les entités du jeu ======>--
local EntityManager = {}

function EntityManager:new()
    local em = {}
    em.lstEntities = {}

    setmetatable(em, self)
    self.__index = self
    return em
end

function EntityManager:addEntity(pEntity)
    if pEntity == nil then
        print("entity nil")
    end
    
    table.insert(self.lstEntities, pEntity)
end

function EntityManager:deleteEntity()
    
    for i=#self.lstEntities, 1, -1 do        
        entity = self.lstEntities[i]
        if entity.toDelete then
            table.remove(self.lstEntities, i)
        end
    end
end

function EntityManager:update(dt)
    for i=1, #self.lstEntities do
        entity = self.lstEntities[i]

        entity:update(dt)
    end
    self:deleteEntity()
end

function EntityManager:draw()
    for i=1, #self.lstEntities do
        entity = self.lstEntities[i]

        entity:draw()
    end
    love.graphics.print(self:countEntityByType(), 120, 10)
end

function EntityManager:countEntityByType()
    local nHero = 0
    local nEnemy = 0
    local nBullet = 0

    for i=1, #self.lstEntities do
        entity = self.lstEntities[i]
        if entity.entityType == "Hero" then
            nHero = nHero + 1
        elseif entity.entityType == "Enemy" then
            nEnemy = nEnemy + 1
        elseif entity.entityType == "Bullet" then
            nBullet = nBullet + 1
        end
    end

    return "Hero : "..nHero.." , Enemy : "..nEnemy.." , Bullet : "..nBullet
end

return EntityManager