EntityManager = require("/Managers/EntityManager")
Hero = require("/Objects/Hero")
local Enemy = require("/Objects/Enemy")


--<====== Classe pour la scene de Jeu ======>--
local GameScene = {}

function GameScene:new()
    local gs = {}
    gs.type = "Game"
    gs.isPaused = false
    gs.isGameOver = false

    gs.MAX_ENEMIES = 100
    gs.spawnTimer = 0
    gs.spawnRate = 3
    gs.minSpawnRate = 0.5
    gs.lastRateScore = 0
    
    setmetatable(gs, self)
    self.__index = self

    return gs
end

function GameScene:load()    
    self.isPaused = false
    self.isGameOver = false

    em = EntityManager:new()
    hero = Hero:new(SCREEN_WIDTH/2,SCREEN_HEIGHT/2)  

    hero:load()
    em:addEntity(hero)
end

function GameScene:unload()
    hero = nil
    em = nil
    love.mouse.setCursor()
end

function GameScene:update(dt)
    if self.isPaused then
        return
    end
    if em.nEnemy < self.MAX_ENEMIES then
        self:enemySpawn(dt)
    end
    em:update(dt)
    em:checkCollision()
    em:deleteEntity()

    if hero.life <= 0 then
        self.isGameOver = true
    end
end

function GameScene:draw()    
    fm:setFont("Game")
    em:draw()
    print(self:getSpawnInterval())
end

function GameScene:keypressed(key)

end

function GameScene:enemySpawn(dt)
    self.spawnTimer = self.spawnTimer + dt

    self:getSpawnInterval()
    if self.spawnTimer >= self.spawnRate then
        local enemy = Enemy:new()
        enemy:load()        
        em:addEntity(enemy)

        self.spawnTimer = 0
    end
end

-- Fonction pour calculer l'intervalle en fonction du score
function GameScene:getSpawnInterval()

    local rateScore = math.floor(hero.score / 200) 
    if rateScore > self.lastRateScore then
        self.lastRateScore = rateScore
        self.spawnRate = math.max(self.spawnRate - 0.1, self.minSpawnRate)
    end
    
    return self.spawnRate
end

return GameScene