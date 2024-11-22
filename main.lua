
local SceneManager = require("/Managers/SceneManager")
local LocaleManager = require("/Managers/LocaleManager")

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
end

function love.update(dt)
end

function love.draw()
    sm:draw()
end

function love.keypressed(key)
    if key == "l" then
        lm:switchLanguage()
    end
    sm:keypressed(key)
end

