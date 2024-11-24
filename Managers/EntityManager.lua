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

function EntityManager:update(dt)
    for i=1, #self.lstEntities do
        entity = self.lstEntities[i]

        entity:update(dt)
    end
end

function EntityManager:draw()
    for i=1, #self.lstEntities do
        entity = self.lstEntities[i]

        entity:draw()
    end
end

return EntityManager