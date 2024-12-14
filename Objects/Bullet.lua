local Vector2 = require("/Libs/Vector2")

--<====== Classe permettant de créer une Bullet ======>--
local Bullet = {}

function Bullet:new(pEntity, pAngle, pType)
    local n = {}
    local startX = pEntity.pos.x + math.cos(pAngle) * 35
    local startY = pEntity.pos.y + math.sin(pAngle) * 35
    n.pos = Vector2:new(startX, startY)
    n.entityType = "Bullet"
    n.type = pType or 1
    n.img = {}
    n.width = 0
    n.height = 0
    n.fireSpd = pEntity.fireSpd
    n.fireRate = pEntity.fireRate
    n.fireRange = pEntity.fireRange
    n.angle = pAngle
    n.velocity = Vector2:new()
    n.toDelete = false
   
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
    self.velocity.x = self.fireSpd * math.cos(self.angle) 
    self.velocity.y = self.fireSpd * math.sin(self.angle)
    -- Applique la Vélocité
    self.pos.x = self.pos.x + self.velocity.x * self.fireRate * dt
    self.pos.y = self.pos.y + self.velocity.y * self.fireRate * dt

    self:checkBorderCollision()
end

function Bullet:draw()
    love.graphics.draw(self.img, self.pos.x, self.pos.y, self.angle + math.rad(-90), 1, 1, self.width/2, self.height/2)
    drawCollideBox(self.pos.x - self.width / 2, self.pos.y - self.height/2, self.width, self.height)
end


function Bullet:keypressed(key)
end

function Bullet:checkBorderCollision()
    if self.pos.x < self.width/2 then
        self.toDelete = true
    elseif self.pos.x > SCREEN_WIDTH - self.width/2 then         
        self.toDelete = true
    end
    if self.pos.y < self.height / 2 then
        self.toDelete = true
    elseif self.pos.y > SCREEN_HEIGHT - self.height / 2 then         
        self.toDelete = true
    end
end

return Bullet