--<====== Classe pour la scene de Debug ======>--
local DebugScene = {}

function DebugScene:new()
    local ds = {}
    ds.type = "Debug"

    setmetatable(ds, self)
    self.__index = self

    return ds
end

function DebugScene:load()

end

function DebugScene:update()

end

function DebugScene:draw()
    love.graphics.print(self.type, 400, 300)
end

return DebugScene