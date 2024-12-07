local Vector2 = require("/Libs/Vector2")

--<====== Classe permettant de créer un Sprite ======>--
local Hero = {}

function Hero:new(pX, pY)
    local h = {}
    h.pos = Vector2:new(pX or 100, pY or 100)
    h.velocity = Vector2:new()
    h.spd = 200
    h.scale = 2

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
end

function Hero:update(dt)
    self:animate(dt)

    local direction = Vector2:new()

    if love.keyboard.isDown("right") then
        direction.x = 1
    elseif love.keyboard.isDown("left") then
        direction.x = -1
    end
    
    if love.keyboard.isDown("up") then
        direction.y = -1
    elseif love.keyboard.isDown("down") then
        direction.y = 1
    end
    
    if direction.x ~= 0 or direction.y ~= 0 then
        direction:normalize()
        self.velocity = direction * self.spd
        if math.abs(direction.x) > math.abs(direction.y) then
            self.state = direction.x > 0 and "walkright" or "walkleft"
        else
            self.state = direction.y > 0 and "walkdown" or "walkup"
        end
    else
        self.velocity = Vector2:new()
        self.state = "idle" 
        self.currentFrame = 1       
    end

    self.pos = self.pos + self.velocity * dt
end

function Hero:draw()
    -- Drawing the hero
    local nFrame = math.floor(self.currentFrame)
    print(nFrame)
    local heroQuad = self.lstSprites[self.state][nFrame]

    love.graphics.draw(self.img[self.state], heroQuad, self.pos.x - self.width / 2, self.pos.y - self.height / 2, 0, self.scale, self.scale, self.width/self.scale, self.height/self.scale)

end

function Hero:animate(dt)
    -- Anim player
    self.currentFrame = self.currentFrame + dt * self.nFrames[self.state]
    if self.currentFrame >= #self.lstSprites[self.state] + 1 then
        self.currentFrame = 1
    end
end

return Hero