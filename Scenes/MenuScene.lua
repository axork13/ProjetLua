--<====== Classe pour la scene de Menu ======>--
local MenuScene = {}

function MenuScene:new()
    local ms = {}
    ms.type = "Menu"

    setmetatable(ms, self)
    self.__index = self

    return ms
end

function MenuScene:load()

end

function MenuScene:unload()

end

function MenuScene:update()

end

function MenuScene:draw()
    love.graphics.print(self.type, 400, 300)
end

return MenuScene