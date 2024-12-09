local EntityManager = require("/Managers/EntityManager")
local Hero = require("/Objects/Hero")
local Enemy = require("/Objects/Enemy")


--<====== Classe pour la scene de Jeu ======>--
local GameScene = {}

function GameScene:new()
    local gs = {}
    gs.type = "Game"
    
    setmetatable(gs, self)
    self.__index = self

    return gs
end

function GameScene:load()    
    em = EntityManager:new()
    hero = Hero:new(100,100)    
    hero:load()
    em:addEntity(hero)
end

function GameScene:unload()
    hero = nil
    em = nil
end

function GameScene:update(dt)
    em:update(dt)
end

function GameScene:draw()    
    em:draw()
end

function GameScene:keypressed(key)
    hero:keypressed(key)
end

return GameScene