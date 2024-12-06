--<====== Classe permettant de créer un Sprite ======>--
local Hero = {}

function Hero:new(pX, pY)
    local h = {}
    h.x = pX or 100
    h.y = pY or 100
    h.vx = 2
    h.vy = 2
    h.spd = 50
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
    self.currentFrame = 1
end

function Hero:update(dt)
    self:animate(dt)
    if love.keyboard.isDown("right") then
        if self.state ~= "walkright" then
            self.state = "walkright"
            self.currentFrame = 1
        end
        self.x = self.x + self.vx * self.spd * dt
    elseif love.keyboard.isDown("left") then
        if self.state ~= "walkleft" then
            self.state = "walkleft"
            self.currentFrame = 1
        end
        self.x = self.x - self.vx * self.spd * dt
    elseif love.keyboard.isDown("up") then
        if self.state ~= "walkup" then
            self.state = "walkup"
            self.currentFrame = 1
        end
        self.y = self.y - self.vy * self.spd * dt
    elseif love.keyboard.isDown("down") then
        if self.state ~= "walkdown" then
            self.state = "walkdown"
            self.currentFrame = 1
        end
        self.y = self.y + self.vy * self.spd * dt
    elseif self.state ~= "idle" then
        self.state = "idle"
        self.currentFrame = 1
    end  
end

function Hero:draw()
    -- Drawing the hero
    local nFrame = math.floor(self.currentFrame)
    local heroQuad = self.lstSprites[self.state][nFrame]

    love.graphics.draw(self.img[self.state], heroQuad, self.x - self.width / 2, self.y - self.height / 2, 0, self.scale, self.scale, self.width/self.scale, self.height/self.scale)

end

function Hero:animate(dt)
    -- Anim player
    self.currentFrame = self.currentFrame + dt * self.nFrames[self.state]
    if self.currentFrame >= #self.lstSprites[self.state] + 1 then
        self.currentFrame = 1
    end
end

return Hero