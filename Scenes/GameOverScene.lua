--<====== Classe pour la scene de Game Over ======>--
local GameOverScene = {}

function GameOverScene:new()
    local gos = {}
    gos.type = "GameOver"

    setmetatable(gos, self)
    self.__index = self

    return gos
end

function GameOverScene:load()

end

function GameOverScene:unload()

end

function GameOverScene:update()

end

function GameOverScene:draw()
    fm:setFont("GameOver")
    
    local text = "-- GAME OVER --"
    love.graphics.print(text, (SCREEN_WIDTH - fm:getCurrentFontWidth(text))/2, (SCREEN_HEIGHT - fm:getCurrentFontHeight())/2)
end

return GameOverScene