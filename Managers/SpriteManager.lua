--<====== Classe permettant de gérer les Sprites ======>--
local SpriteManager = {}

function SpriteManager:new()
    local sm = {}

    setmetatable(sm, self)
    self.__index = self
    return sm
end

return SpriteManager