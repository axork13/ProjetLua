local Vector2 = require("/Libs/Vector2")
local Bullet = require("/Objects/Bullet")

--<====== Classe permettant de créer un Sprite ======>--
local Hero = {}

function Hero:new(pX, pY)
    local h = {}
    h.pos = Vector2:new(pX or 100, pY or 100)
    h.velocity = Vector2:new()
    h.mouseDirection = Vector2:new()
    h.spd = 200
    h.scale = 2
    h.life = 5
    h.oldButtonDown = false

    h.img = {}
    h.lstSprites = {}
    h.nFrames = {}
    h.lstSprites["idle"] = {}
    h.nFrames["idle"] = 2
    h.lstSprites["walkleft"] = {}
    h.nFrames["walkleft"] = 6
    h.lstSprites["walkright"] = {}
    h.nFrames["walkright"] = 6
    h.lstSprites["walkup"] = {}
    h.nFrames["walkup"] = 6
    h.lstSprites["walkdown"] = {}
    h.nFrames["walkdown"] = 6
    h.lstSprites["attack"] = {}
    h.nFrames["attack"] = 2

    h.state = "idle"
    h.width = 48
    h.height = 48
    h.currentFrame = 1

    setmetatable(h, self)
    self.__index = self

    return h
end

function Hero:loadImageState(pState, pStart, pImageName)
    local imageName = pImageName or pState
    self.img[pState] = love.graphics.newImage("/Assets/Images/hero/"..imageName.."_hero.png")
    
    start = pStart or 1
    for i=start, start + self.nFrames[pState] - 1 do
        local mySprite = love.graphics.newQuad((i-1)*self.width, 0, self.width, self.height, self.img[pState])
        table.insert(self.lstSprites[pState], mySprite)        
    end
end

function Hero:load()
    self:loadImageState("idle", 1)
    self:loadImageState("walkup", 1, "walk")
    self:loadImageState("walkdown", 7, "walk")
    self:loadImageState("walkright", 13, "walk")
    self:loadImageState("walkleft", 19, "walk")
    imgHalfLeft = love.graphics.newImage("/Assets/Images/hero/half_heart_left.png")
    imgHalfRight = love.graphics.newImage("/Assets/Images/hero/half_heart_right.png")
    mouseTarget = love.mouse.newCursor("/Assets/Images/hero/mouseTarget.png",8,8)
    love.mouse.setCursor(mouseTarget)
end

function Hero:update(dt)    
    -- Récupération coordonnées de la souris
    local mousex, mousey = love.mouse.getPosition()
    local direction = Vector2:new()

    if love.keyboard.isScancodeDown('d', 'right') then
        direction.x = 1
    elseif love.keyboard.isScancodeDown('a', 'left') then
        direction.x = -1
    end
    
    if love.keyboard.isScancodeDown('w', 'up') then
        direction.y = -1
    elseif love.keyboard.isScancodeDown('s', 'down') then
        direction.y = 1
    end
    
    if direction.x ~= 0 or direction.y ~= 0 then
        direction:normalize()
        self.velocity = direction * self.spd        
    else
        self.velocity = Vector2:new()
        self.state = "idle"   
    end

    local angle = math.angle(self.pos.x, self.pos.y, mousex, mousey)
    self.mouseDirection = Vector2:new(self.pos.x * math.cos(angle), self.pos.y * math.sin(angle))
    if math.abs(self.mouseDirection.x) > math.abs(self.mouseDirection.y) then
        self.state = self.mouseDirection.x > 0 and "walkright" or "walkleft"
    else
        self.state = self.mouseDirection.y > 0 and "walkdown" or "walkup"
    end    
    
    self.pos = self.pos + self.velocity * dt
    
    if love.mouse.isDown(1) then
        if oldButtonDown==false then            
            -- local x = math.cos(angle) * 24 + self.pos.x
            -- local y = math.sin(angle) * 24 + self.pos.y
            local bullet = Bullet:new(self.pos.x, self.pos.y, angle, 1)
            bullet:load()
            em:addEntity(bullet)
        end
        oldButtonDown = true
    else
        oldButtonDown = false
    end

    self:animate(dt)
end

function Hero:draw()
    self:drawLife()

    -- Drawing the hero
    local nFrame = math.floor(self.currentFrame)
    local heroQuad = self.lstSprites[self.state][nFrame]

    love.graphics.draw(self.img[self.state], heroQuad, self.pos.x, self.pos.y, 0,self.scale, self.scale, self.width/self.scale, self.height/self.scale)

end

function Hero:animate(dt)
    -- Anim player
    self.currentFrame = self.currentFrame + dt * self.nFrames[self.state]
    if self.currentFrame >= #self.lstSprites[self.state] + 1 then
        self.currentFrame = 1
    end
end

function Hero:drawLife()
    for i=0.5, self.life, 0.5 do
        if i%1 == 0 then
            love.graphics.draw(imgHalfRight, 18*(i-0.5), 10)
        else
            if self.life == 0.5 then 
                if math.floor(love.timer.getTime()*3) % 2 == 0 then
                    love.graphics.draw(imgHalfLeft, 18*i, 10)
                end
            else
                love.graphics.draw(imgHalfLeft, 18*i, 10)
            end
        end
    end  
end

function Hero:keypressed(key)
    if key == "kp-" then
        self.life = self.life - 0.5
    end

    if key == "kp+" then
        self.life = self.life + 0.5
    end
end

return Hero