
local SceneManager = require("/Managers/SceneManager")
local LocaleManager = require("/Managers/LocaleManager")
local EntityManager = require("/Managers/EntityManager")
local Hero = require("/Objects/Hero")
local Enemy = require("/Objects/Enemy")

--< Empèche Love de filtrer les contours des images quand elles sont redimentionnées >--
--< Indispensable pour du pixel art >--
love.graphics.setDefaultFilter("nearest")

--<= VARIABLE GLOBALE DU JEU >--
SCREEN_WIDTH, SCREEN_HEIGHT = love.graphics.getDimensions()

function love.load()
    lm = LocaleManager:new()
    lm:load(lm.currentLanguage)

    sm = SceneManager:new()
    sm:load()   

    em = EntityManager:new()
    hero = Hero:new()    
    hero:load()
    em:addEntity(hero)
end

function love.update(dt)
    em:update(dt)
end

function love.draw()
    sm:draw()
    em:draw()
end

function love.keypressed(key)
    if key == "l" then
        lm:switchLanguage()
    end
    sm:keypressed(key)
end

