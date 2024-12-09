--<====== Classe pour la scene de Menu ======>--
local MenuScene = {}

function MenuScene:new()
    local ms = {}
    ms.type = "Menu"
    ms.textGameTitle = "Veggies Vengeance"
    ms.textPlay = "Jouer"
    ms.textQuit = "Quitter"

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
    fm:setFont("GameTitle")
    love.graphics.print(self.textGameTitle, (SCREEN_WIDTH - fm:getCurrentFontWidth(self.textGameTitle))/2, (SCREEN_HEIGHT - fm:getCurrentFontHeight())/4)
    
    fm:setFont("Menu")  
    love.graphics.print(self.textPlay, (SCREEN_WIDTH - fm:getCurrentFontWidth(self.textPlay))/2, (SCREEN_HEIGHT - fm:getCurrentFontHeight())/2)
    love.graphics.print(self.textQuit, (SCREEN_WIDTH - fm:getCurrentFontWidth(self.textQuit))/2, (SCREEN_HEIGHT - fm:getCurrentFontHeight())/2 + fm:getCurrentFontHeight())
end

return MenuScene