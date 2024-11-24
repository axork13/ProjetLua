--<====== Classe permettant de créer un Sprite ======>--
local Hero = {}

function Hero:new(pX, pY)
    local h = {}
    h.x = 100 or pX
    h.y = 100 or pY
    h.vx = 1
    h.spd = 50

    h.spriteSheet = {}
    h.spriteSheet.nLines = 9
    h.spriteSheet.nCols = 8
    h.lstSprites = {}
    h.nFrames = {}
    h.lstSprites["idle"] = {}
    h.nFrames["idle"] = 2
    h.lstSprites["blink"] = {}
    h.nFrames["blink"] = 2
    h.lstSprites["walk"] = {}
    h.nFrames["walk"] = 2
    h.lstSprites["run"] = {}
    h.nFrames["run"] = 2
    h.lstSprites["duck"] = {}
    h.nFrames["duck"] = 2
    h.lstSprites["jump"] = {}
    h.nFrames["jump"] = 2
    h.lstSprites["disappear"] = {}
    h.nFrames["disappear"] = 2
    h.lstSprites["die"] = {}
    h.nFrames["die"] = 2
    h.lstSprites["attack"] = {}
    h.nFrames["attack"] = 2

    h.state = "idle"
    h.width = 32
    h.height = 32


    setmetatable(h, self)
    self.__index = self
    return h
end

function Hero:load()
    self.spriteSheet.img = love.graphics.newImage("/Assets/Images/Hero_spriteSheet.png")

    for c=1, self.spriteSheet.nCols do
        for l=1, self.spriteSheet.nLines do
            if l == 1 then
                local mySprite = love.graphics.newQuad((c-1)*self.width, (l-1)*self.height, self.width, self.height, self.spriteSheet.img)
                table.insert(self.lstSprites["idle"], mySprite)
            end
        end
    end
    self.currentImage = 1
end

function Hero:update(dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.vx * self.spd * dt
    end
end

function Hero:draw()
    -- Drawing the hero
    local nImage = math.floor(self.currentImage)
    local heroQuad = self.lstSprites[self.state][nImage]

    love.graphics.draw(self.spriteSheet.img, heroQuad, self.x - self.width / 2, self.y - self.height / 2, 0, 1, 1, self.width/2, self.height/2)

end

return Hero