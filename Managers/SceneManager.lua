local Debug = require("/Scenes/DebugScene")
local Menu = require("/Scenes/MenuScene")
local Game = require("/Scenes/GameScene")
local Pause = require("/Scenes/PauseScene")
local GameOver = require("/Scenes/GameOverScene")
local Victory = require("/Scenes/VictoryScene")

--<====== Classe permettant de gérer les Scenes ======>--
local SceneManager = {}

function SceneManager:new()
    local sm = {}
    sm.lstScene = {}
    sm.currentGameScene = nil

    setmetatable(sm, self)
    self.__index = self

    return sm
end

function SceneManager:load()
    self.lstScene["Debug"] = Debug:new()
    self.lstScene["Menu"] = Menu:new()
    self.lstScene["Game"] = Game:new()
    self.lstScene["Pause"] = Pause:new()
    self.lstScene["GameOver"] = GameOver:new()
    self.lstScene["Victory"] = Victory:new()


    self.currentScene = self.lstScene["Menu"]
end

function SceneManager:update(dt)
    self.currentScene:update(dt)
end

function SceneManager:draw()
    if self.currentGameScene then
        self.currentGameScene:draw()
    end
    
    self.currentScene:draw()
end

function SceneManager:keypressed(key, scancode, isrepeat)
    if key == "g" then
        self.currentScene:unload()
        self:switchScene("Game")  
        self.currentScene:load()      
    end

    if key == "m" then
        self.currentScene:unload()
        self:switchScene("Menu")
        self.currentScene:load()
    end

    if scancode == "p" then        
        if self.currentScene.type == "Game" then
            self.currentScene.isPaused = true
            self.currentGameScene = self.currentScene
            self:switchScene("Pause")
        elseif self.currentScene.type == "Pause" then
            self:switchScene("Game")
            self.currentScene.isPaused = false
        end
    end       
end

function SceneManager:switchScene(pSceneType)
    self.currentScene = self.lstScene[pSceneType]    
end

function SceneManager:getSceneType()
    return self.currentScene.type 
end

return SceneManager