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
    fm:setFont("Pause")
    
    local text = "-- PAUSE --"
    love.graphics.print(text, (SCREEN_WIDTH - fm:getCurrentFontWidth(text))/2, (SCREEN_HEIGHT - fm:getCurrentFontHeight())/2)
end

function PauseScene:unload()

end

return PauseScene