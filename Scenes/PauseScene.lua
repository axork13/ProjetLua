--<====== Classe pour la scene de Pause ======>--
local PauseScene = {}

function PauseScene:new()
    local ps = {}
    ps.type = "Pause"

    setmetatable(ps, self)
    self.__index = self

    return ps
end

function PauseScene:load()

end

function PauseScene:update()

end

function PauseScene:draw()
    love.graphics.print("-- PAUSE --", SCREEN_WIDTH/2 - 22, SCREEN_HEIGHT/2)
end

return PauseScene