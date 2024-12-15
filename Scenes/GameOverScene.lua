--<====== Classe pour la scene de Game Over ======>--
local GameOverScene = {}

function GameOverScene:new()
    local gos = {}
    gos.type = "GameOver"
    gos.gameScore = 0

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
    love.graphics.print("Score : "..self.gameScore, (SCREEN_WIDTH - fm:getCurrentFontWidth("Score : "..self.gameScore))/2, (SCREEN_HEIGHT - fm:getCurrentFontHeight())/2 + 30)

end

return GameOverScene