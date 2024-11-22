--<====== Classe permettant de gérer les fonts ======>--
local FontManager = {}

function FontManager:new()
    local fm = {}

    setmetatable(fm, self)
    self.__index = self
    return fm
end

return FontManager