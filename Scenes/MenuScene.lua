--<====== Classe pour la scene de Menu ======>--
local MenuScene = {}

function MenuScene:new()
    local ms = {}
    ms.type = "Menu"
    ms.textGameTitle = "Veggies Vengeance"
    
    self.textPlay = lm.locale["menu"]["play"]
    self.textQuit = lm.locale["menu"]["quit"]

    self.imgControl = love.graphics.newImage("/Assets/Images/menu/"..lm.locale["menu"]["control"]..".png")
    self.imgArrows = love.graphics.newImage("/Assets/Images/menu/arrows.png")
    self.imgOROU = love.graphics.newImage("/Assets/Images/menu/"..lm.locale["menu"]["orou"]..".png")


    setmetatable(ms, self)
    self.__index = self

    return ms
end

function MenuScene:load()
    self.textPlay = lm.locale["menu"]["play"]
    self.textQuit = lm.locale["menu"]["quit"]
    self.imgControl = love.graphics.newImage("/Assets/Images/menu/"..lm.locale["menu"]["control"]..".png")
    self.imgArrows = love.graphics.newImage("/Assets/Images/menu/arrows.png")
    self.imgOROU = love.graphics.newImage("/Assets/Images/menu/"..lm.locale["menu"]["orou"]..".png")
    
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

    love.graphics.draw(self.imgOROU, 170, SCREEN_HEIGHT/4 * 3 - 50)

    love.graphics.draw(self.imgControl, 100, SCREEN_HEIGHT/4 * 3, 0, 2, 2)
    love.graphics.draw(self.imgArrows, 250, SCREEN_HEIGHT/4 * 3, 0, 2, 2)
end

return MenuScene