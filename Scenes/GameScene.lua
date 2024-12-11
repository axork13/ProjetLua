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
    hero = Hero:new(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)  

    hero:load()
    em:addEntity(hero)
    enemy = Enemy:new()
    enemy2 = Enemy:new()
    enemy3 = Enemy:new()
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