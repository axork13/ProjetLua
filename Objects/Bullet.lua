local Vector2 = require("/Libs/Vector2")

--<====== Classe permettant de créer une Bullet ======>--
local Bullet = {}

function Bullet:new(pX, pY, pAngle, pType)
    local n = {}
    n.pos = Vector2:new(pX or 100, pY or 100)
    n.type = pType or 1
    n.img = {}
    n.width = 0
    n.height = 0
    n.spd = 50
    n.angle = pAngle
    n.direction = Vector2:new()
   
    setmetatable(n, self)
    self.__index = self

    return n
end

function Bullet:load()
    if self.type == 2 then
        self.img = love.graphics.newImage("/Assets/Images/bullet/bullet2.png")
    else
        self.img = love.graphics.newImage("/Assets/Images/bullet/bullet1.png")
    end    
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()  
end

function Bullet:update(dt)    
    self.direction.x = self.spd * math.cos(self.angle) 
    self.direction.y = self.spd * math.sin(self.angle)
    -- Applique la Vélocité
    self.direction:normalize()   

    self.pos.x = self.pos.x + (self.direction.x * 60 * dt) 
    self.pos.y = self.pos.y + (self.direction.y * 60 * dt)
end

function Bullet:draw()
    love.graphics.draw(self.img, self.pos.x, self.pos.y, self.angle + math.rad(-90), 1, 1, self.width/2, self.height/2)
end

function Bullet:keypressed(key)
end

return Bullet