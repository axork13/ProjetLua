local EntityManager = require("/Managers/EntityManager")
local Hero = require("/Objects/Hero")
local Enemy = require("/Objects/Enemy")


--<====== Classe pour la scene de Jeu ======>--
local GameScene = {}

function GameScene:new()
    local gs = {}
    gs.type = "Game"
    gs.isPaused = false
    
    setmetatable(gs, self)
    self.__index = self

    return gs
end

function GameScene:load()    
    self.isPaused = false
    em = EntityManager:new()
    hero = Hero:new(100,100)    
    hero:load()
    em:addEntity(hero)
    enemy = Enemy:new(100, 100)
    enemy2 = Enemy:new(200, 400)
    enemy3 = Enemy:new(400, 400)
    enemy:load()
    enemy2:load()
    enemy3:load()
    em:addEntity(enemy)
    em:addEntity(enemy2)
    em:addEntity(enemy3)
end

function GameScene:unload()
    hero = nil
    em = nil
end

function GameScene:update(dt)
    if self.isPaused then
        return
    end
    em:update(dt)
end

function GameScene:draw()    
    fm:setFont("Game")
    em:draw()
end

function GameScene:keypressed(key)


end

return GameScene