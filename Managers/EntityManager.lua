--<====== Classe permettant de gérer toute les entités du jeu ======>--
local EntityManager = {}

function EntityManager:new()
    local em = {}
    em.lstEntities = {}
    em.nHero = 0
    em.nEnemy = 0
    em.nBullet = 0

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
end

function EntityManager:draw()
    for i=1, #self.lstEntities do
        entity = self.lstEntities[i]

        entity:draw()
    end
    love.graphics.print(self:countEntityByType(), 120, 10)
end

function EntityManager:countEntityByType()
    self.nHero = 0
    self.nEnemy = 0
    self.nBullet = 0
    for i=1, #self.lstEntities do
        entity = self.lstEntities[i]
        if entity.entityType == "Hero" then
            self.nHero = self.nHero + 1
        elseif entity.entityType == "Enemy" then
            self.nEnemy = self.nEnemy + 1
        elseif entity.entityType == "Bullet" then
            self.nBullet = self.nBullet + 1
        end
    end

    return "Hero : "..self.nHero.." , Enemy : "..self.nEnemy.." , Bullet : "..self.nBullet
end

function EntityManager:checkCollision()
    for i=1, #self.lstEntities do
        if self.lstEntities[i].entityType == "Enemy" then
            local enemy = self.lstEntities[i]
            local enemyBox = {
                x = enemy.pos.x + enemy.width/(enemy.scale*2),
                y = enemy.pos.y-(enemy.scale*2),
                w = enemy.width/(enemy.scale),
                h = enemy.height-(enemy.scale*2)
            }

            for j=1, #self.lstEntities do
                -- Check collision Enemy/Bullet
                if self.lstEntities[j].entityType == "Bullet" then
                    local bullet = self.lstEntities[j]
            
                    local bulletBox = {
                        x = bullet.pos.x - bullet.width / 2, 
                        y = bullet.pos.y - bullet.height/2,
                        w = bullet.width,
                        h = bullet.height
                    }                   

                    if checkAABBCollision(bulletBox.x, bulletBox.y, bulletBox.w, bulletBox.h, enemyBox.x, enemyBox.y, enemyBox.w, enemyBox.h) then
                        bullet.toDelete = true
                        enemy:takeDamage()
                    end
                end

                -- Check collision Enemy/Hero
                if self.lstEntities[j].entityType == "Hero" then
                    local hero = self.lstEntities[j]
            
                    local heroBox = {
                        x = hero.pos.x + hero.width/(hero.scale*2),
                        y = hero.pos.y-(hero.scale*2),
                        w = hero.width/(hero.scale),
                        h = hero.height-(hero.scale*2)
                    }                   

                    if checkAABBCollision(heroBox.x, heroBox.y, heroBox.w, heroBox.h, enemyBox.x, enemyBox.y, enemyBox.w, enemyBox.h) then
                        hero:takeDamage(0.5)
                    end
                end
            end
        end 
    end
end

return EntityManager