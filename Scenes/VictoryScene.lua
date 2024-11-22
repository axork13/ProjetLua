--<====== Classe pour la scene de Victoire ======>--
local VictoryScene = {}

function VictoryScene:new()
    local vs = {}
    vs.type = "Victory"

    setmetatable(vs, self)
    self.__index = self

    return vs
end

function VictoryScene:load()

end

function VictoryScene:update()

end

function VictoryScene:draw()
    love.graphics.print(self.type, 400, 300)
end

return VictoryScene