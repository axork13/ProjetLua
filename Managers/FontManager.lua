--<====== Classe permettant de gérer les fonts ======>--
local FontManager = {}

function FontManager:new()
    local fm = {}
    fm.fonts = {}
    fm.currentFont = nil

    setmetatable(fm, self)
    self.__index = self
    return fm
end

function FontManager:loadFonts()
    self:addFont("GameTitle", "/Assets/Fonts/Pixel Game.otf", 100) 
    self:addFont("Menu", "/Assets/Fonts/LuckiestGuy.ttf", 40)
    self:addFont("Game", "/Assets/Fonts/LuckiestGuy.ttf", 18)
    self:addFont("Pause", "/Assets/Fonts/LuckiestGuy.ttf", 30)
    self:addFont("GameOver", "/Assets/Fonts/LuckiestGuy.ttf", 30)
end

function FontManager:addFont(pName, pFilename, pSize)
    self.fonts[pName] = love.graphics.newFont(pFilename, pSize)
end

function FontManager:getFont(pName)
    return self.fonts[pName]
end

function FontManager:setFont(pName)
    local font = fm:getFont(pName)    
    love.graphics.setFont(font)
    self.currentFont = font
end

function FontManager:getCurrentFontWidth(pText)
    return self.currentFont:getWidth(pText)
end

function FontManager:getCurrentFontHeight()
    return self.currentFont:getHeight()
end

return FontManager