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

function GameOverScene:update()

end

function GameOverScene:draw()
    love.graphics.print(self.type, 400, 300)
end

return GameOverScene