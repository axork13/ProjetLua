local Vector2 = require("/Libs/Vector2")

--<====== Classe permettant de créer un Sprite ======>--
local Enemy = {}

function Enemy:new(pX, pY)
    local e = {}
    e.pos = Vector2:new(pX or math.random(0, SCREEN_WIDTH), pY or math.random(0, SCREEN_HEIGHT))
    e.spd = math.random(50,100)
    
    local angle = math.angle(e.pos.x, e.pos.y, math.random(0, SCREEN_WIDTH), math. random(0, SCREEN_HEIGHT))
    e.velocity = Vector2:new(e.spd * math.cos(angle), e.spd * math.sin(angle))


    -- while e.direction.x == 0 and e.direction.y == 0 do
    --     e.direction = Vector2:new(math.random(-1,1),math.random(-1,1))
    -- end
    e.scale = 2
    e.life = math.random(1, 5)

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

    e.state = "walkright"
    e.width = 48
    e.height = 48
    e.currentFrame = 1

    setmetatable(e, self)
    self.__index = self

    return e
end

function Enemy:loadImageState(pState, pStart, pImageName)
    local imageName = pImageName or pState
    self.img[pState] = love.graphics.newImage("/Assets/Images/enemies/"..imageName..".png")
    
    start = pStart or 1
    for i=start, start + self.nFrames[pState] - 1 do
        local mySprite = love.graphics.newQuad((i-1)*self.width, 0, self.width, self.height, self.img[pState])
        table.insert(self.lstSprites[pState], mySprite)        
    end
end

function Enemy:load()
    self:loadImageState("walkup", 1, "enemie")
    self:loadImageState("walkdown", 7, "enemie")
    self:loadImageState("walkright", 13, "enemie")
    self:loadImageState("walkleft", 19, "enemie")
end

function Enemy:update(dt)  
    if self.velocity.x ~= 0 or self.velocity.y ~= 0 then
        if math.abs(self.velocity.x) > math.abs(self.velocity.y) then
            self.state = self.velocity.x > 0 and "walkright" or "walkleft"
        else
            self.state = self.velocity.y > 0 and "walkdown" or "walkup"
        end
    end

    self.pos = self.pos + self.velocity * dt

    self:animate(dt)
end

function Enemy:draw()
    -- Drawing the Enemy
    local nImage = math.floor(self.currentFrame)
    local EnemyQuad = self.lstSprites[self.state][nImage]

    love.graphics.draw(self.img[self.state], EnemyQuad, self.pos.x, self.pos.y, 0, self.scale, self.scale, self.width/self.scale, self.height/self.scale)
end

function Enemy:animate(dt)
    -- Anim enemy
    self.currentFrame = self.currentFrame + dt * self.nFrames[self.state]
    if self.currentFrame >= #self.lstSprites[self.state] + 1 then
        self.currentFrame = 1
    end
end

return Enemy