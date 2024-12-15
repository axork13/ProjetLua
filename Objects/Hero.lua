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
    h.life = 0.5
    h.toDelete = false
    h.isInvincible = false
    h.invincibleTimer = 0
    h.invincibleDuration = 1
    h.entityType = "Hero"
    
    h.fireSpd = 60
    h.fireRate = 2
    h.fireRange = 200

    h.oldButtonDown = false

    h.score = 0

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
            local bullet = Bullet:new(self, angle, 1)
            bullet:load()
            em:addEntity(bullet)
        end
        oldButtonDown = true
    else
        oldButtonDown = false
    end

    -- Frame d'invulnérabilité après un hit
    if self.isInvincible then
        self.invincibleTimer = self.invincibleTimer - dt
        if self.invincibleTimer <= 0 then
            self.isInvincible = false
        end
    end
    self:checkBorderCollision()
    self:animate(dt)
end

function Hero:draw()
    self:drawLife()
    
    fm:setFont("Game")
    
    love.graphics.print("Score : "..self.score, (SCREEN_WIDTH - fm:getCurrentFontWidth("Score : "..self.score))/2, 10)


    -- Drawing the hero
    local nFrame = math.floor(self.currentFrame)
    local heroQuad = self.lstSprites[self.state][nFrame]

    if self.isInvincible then
        if math.floor(self.invincibleTimer * 10) % 2 == 0 then
            love.graphics.setColor(1, 1, 1, 0.5) -- Transparence partielle
        else
            love.graphics.setColor(1, 1, 1, 1) -- Couleur normale
        end
    else
        love.graphics.setColor(1, 1, 1, 1) -- Couleur normale
    end
    love.graphics.draw(self.img[self.state], heroQuad, self.pos.x, self.pos.y, 0,self.scale, self.scale, self.width/(self.scale*2), self.height/(self.scale*2))
    drawCollideBox(self.pos.x + self.width/(self.scale*2), self.pos.y-(self.scale*2), self.width/(self.scale), self.height-(self.scale*2))
    love.graphics.setColor(1, 1, 1, 1) -- Couleur normale

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

function Hero:takeDamage(pDamage)
    if not self.isInvincible then
        self.life = self.life - pDamage
        self.isInvincible = true
        self.invincibleTimer = self.invincibleDuration
    end
    if self.life <= 0 then
        self.toDelete = true
    end
end

function Hero:checkBorderCollision()
    if self.pos.x < -self.width/(self.scale*2) then
        self.pos.x = -self.width/(self.scale*2)
    elseif self.pos.x > SCREEN_WIDTH - self.width/(self.scale*2) - self.width/2 then
        self.pos.x = SCREEN_WIDTH - self.width/(self.scale*2) - self.width/2
    end

    if self.pos.y < -self.height/(self.scale) + self.height/2 + (self.scale*2) then
        self.pos.y = -self.width/(self.scale) + self.height/2 + (self.scale*2)
    elseif self.pos.y > SCREEN_HEIGHT - self.height / (self.scale*2) - self.height/2 - (self.scale*2) then
        self.pos.y = SCREEN_HEIGHT - self.height / (self.scale*2) - self.height/2 - (self.scale*2)
    end
end

return Hero