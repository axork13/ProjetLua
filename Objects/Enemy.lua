--<====== Classe permettant de créer un Sprite ======>--
local Enemy = {}

function Enemy:new(pX, pY)
    local e = {}
    e.x = 100 or pX
    e.y = 100 or pY
    e.vx = 1
    e.spd = 50

    e.spriteSheet = {}
    e.spriteSheet.nLines = 9
    e.spriteSheet.nCols = 8
    e.lstSprites = {}
    e.nFrames = {}
    e.lstSprites["idle"] = {}
    e.nFrames["idle"] = 2
    e.lstSprites["blink"] = {}
    e.nFrames["blink"] = 2
    e.lstSprites["walk"] = {}
    e.nFrames["walk"] = 2
    e.lstSprites["run"] = {}
    e.nFrames["run"] = 2
    e.lstSprites["duck"] = {}
    e.nFrames["duck"] = 2
    e.lstSprites["jump"] = {}
    e.nFrames["jump"] = 2
    e.lstSprites["disappear"] = {}
    e.nFrames["disappear"] = 2
    e.lstSprites["die"] = {}
    e.nFrames["die"] = 2
    e.lstSprites["attack"] = {}
    e.nFrames["attack"] = 2

    e.state = "idle"
    e.width = 32
    e.height = 32


    setmetatable(e, self)
    self.__index = self
    return e
end

function Enemy:load()
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

function Enemy:update(dt)
   
end

function Enemy:draw()
    -- Drawing the Enemy
    local nImage = math.floor(self.currentImage)
    local EnemyQuad = self.lstSprites[self.state][nImage]

    love.graphics.draw(self.spriteSheet.img, EnemyQuad, self.x - self.width / 2, self.y - self.height / 2, 0, 1, 1, self.width/2, self.height/2)

end

return Enemy