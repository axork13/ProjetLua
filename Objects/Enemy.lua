local Vector2 = require("/Libs/Vector2")

--<====== Classe permettant de créer un Sprite ======>--
local Enemy = {}

function Enemy:new(pX, pY)
    local e = {}
    e.pos = Vector2:new(pX or math.random(0, SCREEN_WIDTH), pY or math.random(0, SCREEN_HEIGHT))
    e.spd = math.random(5,20)
    e.velocity = Vector2:new()
    e.entityType = "Enemy"

    e.scale = 2
    e.life = math.random(2, 5)
    e.toDelete = false

    e.state = {}
    e.state.NONE = "None"
    e.state.WALK = "Walk"
    e.state.CHANGEDIR = "ChangeDir"
    e.state.ATTACK = "Attack"
    e.state.RUNAWAY = "RunAway"

    e.currentState = e.state.NONE

    e.img = {}
    e.lstSprites = {}
    e.nFrames = {}
    e.lstSprites["walkleft"] = {}
    e.nFrames["walkleft"] = 6
    e.lstSprites["walkright"] = {}
    e.nFrames["walkright"] = 6
    e.lstSprites["walkup"] = {}
    e.nFrames["walkup"] = 6
    e.lstSprites["walkdown"] = {}
    e.nFrames["walkdown"] = 6

    e.imgState = "walkright"
    
    e.width = 48
    e.height = 48
    e.currentFrame = 1

    setmetatable(e, self)
    self.__index = self

    return e
end

function Enemy:loadImageState(pImgState, pStart, pImageName)
    local imageName = pImageName or pImgState
    self.img[pImgState] = love.graphics.newImage("/Assets/Images/enemies/"..imageName..".png")
    
    start = pStart or 1
    for i=start, start + self.nFrames[pImgState] - 1 do
        local mySprite = love.graphics.newQuad((i-1)*self.width, 0, self.width, self.height, self.img[pImgState])
        table.insert(self.lstSprites[pImgState], mySprite)        
    end
end

function Enemy:load()
    self:loadImageState("walkup", 1, "enemie")
    self:loadImageState("walkdown", 7, "enemie")
    self:loadImageState("walkright", 13, "enemie")
    self:loadImageState("walkleft", 19, "enemie")
end

function Enemy:update(dt)  
    local vx, vy
    if self.currentState == self.state.NONE then
        self.currentState = self.state.CHANGEDIR
    end

    if self.currentState == self.state.CHANGEDIR then
        self.spd = math.random(5, 20)
        local angle = math.angle(self.pos.x, self.pos.y, math.random(0, SCREEN_WIDTH), math.random(0, SCREEN_HEIGHT))
        vx = self.spd * math.cos(angle)
        vy = self.spd * math.sin(angle)
        self.velocity = Vector2:new(vx,vy)

        if self.velocity.x ~= 0 or self.velocity.y ~= 0 then
            if math.abs(self.velocity.x) > math.abs(self.velocity.y) then
                self.imgState = self.velocity.x > 0 and "walkright" or "walkleft"
            else
                self.imgState = self.velocity.y > 0 and "walkdown" or "walkup"
            end
        end
        
        self.currentState = self.state.WALK
    end

    if self.currentState == self.state.RUNAWAY then    
        local detectionRadius = 200
        local distance = math.dist(self.pos.x, self.pos.y, hero.pos.x,hero.pos.y)
        if distance < detectionRadius then
            self:runAwayFrom(hero)
        end
        self.currentState = self.state.WALK
    end

    if self.currentState == self.state.WALK then        
        self.pos = self.pos + self.velocity * dt
        self:checkBorderCollision()
    end    

    if self.life <= 1 and self.currentState == self.state.WALK then
        self.currentState = self.state.RUNAWAY
    end    
    
    self:animate(dt)
end

function Enemy:draw()
    -- Drawing the Enemy
    local nImage = math.floor(self.currentFrame)
    local EnemyQuad = self.lstSprites[self.imgState][nImage]

    love.graphics.draw(self.img[self.imgState], EnemyQuad, self.pos.x, self.pos.y, 0, 2,2, self.width/(self.scale*2), self.height/(self.scale*2))

    drawCollideBox(self.pos.x + self.width/(self.scale*2), self.pos.y-(self.scale*2), self.width/(self.scale), self.height-(self.scale*2))
    love.graphics.print(self.life, self.pos.x + self.width/(self.scale*2), self.pos.y-(self.scale*2))

end

function Enemy:animate(dt)
    -- Anim enemy
    self.currentFrame = self.currentFrame + dt * self.nFrames[self.imgState]
    if self.currentFrame >= #self.lstSprites[self.imgState] + 1 then
        self.currentFrame = 1
    end
end

function Enemy:checkBorderCollision()
    if self.pos.x < -self.width/(self.scale*2) then
        self.pos.x = -self.width/(self.scale*2)
        self.currentState = self.state.CHANGEDIR
    elseif self.pos.x > SCREEN_WIDTH - self.width/(self.scale*2) - self.width/2 then
        self.pos.x = SCREEN_WIDTH - self.width/(self.scale*2) - self.width/2
        self.currentState = self.state.CHANGEDIR
    end
    if self.pos.y < -self.height/(self.scale) + self.height/2 + (self.scale*2) then
        self.pos.y = -self.width/(self.scale) + self.height/2 + (self.scale*2)
        self.currentState = self.state.CHANGEDIR
    elseif self.pos.y > SCREEN_HEIGHT - self.height / (self.scale*2) - self.height/2 - (self.scale*2) then
        self.pos.y = SCREEN_HEIGHT - self.height / (self.scale*2) - self.height/2 - (self.scale*2)
        self.currentState = self.state.CHANGEDIR
    end
end

function Enemy:takeDamage()
    self.life = self.life - 1

    if self.life <= 0 then
        self.toDelete = true
    end
end

function Enemy:runAwayFrom(pHero)
    -- Calculer le vecteur vers la position du héros
    local direction = Vector2:new(pHero.pos.x - self.pos.x, pHero.pos.y - self.pos.y)

    -- Inverser la direction pour aller à l'opposé
    direction = -direction
    direction:normalize()

    -- Multiplier par la vitesse pour obtenir la vélocité
    self.velocity.x = direction.x * self.spd *4
    self.velocity.y = direction.y * self.spd *4
end

return Enemy