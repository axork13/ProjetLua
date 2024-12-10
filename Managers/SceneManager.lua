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
    
    sm.lstScene["Debug"] = Debug:new()
    sm.lstScene["Menu"] = Menu:new()
    sm.lstScene["Game"] = Game:new()
    sm.lstScene["Pause"] = Pause:new()
    sm.lstScene["GameOver"] = GameOver:new()
    sm.lstScene["Victory"] = Victory:new()

    setmetatable(sm, self)
    self.__index = self

    return sm
end

function SceneManager:load()
    self.currentScene = self.lstScene["Menu"]
    self.currentScene:load()
end

function SceneManager:update(dt)
    self.currentScene:update(dt)
end

function SceneManager:draw()
    if self.currentGameScene ~= nil then
        self.currentGameScene:draw()
    end
    
    self.currentScene:draw()
end

function SceneManager:keypressed(key, scancode, isrepeat)
    --< Lancer le jeu avec espace >--
    if scancode == "space" and self.currentScene.type ~= "Game" then
        self.currentScene:unload()
        self:switchScene("Game")  
        self.currentScene:load()      
    end

    --< Revenir au menu depuis la pause >--
    if self.currentScene.type == "Pause" then
        if scancode == "escape" then
            self.currentGameScene = nil
            self.currentScene:unload()
            self:switchScene("Menu")
            self.currentScene:load()
            return
        end
    end

    --< Quitter le jeu depuis le menu >--
    if self.currentScene.type == "Menu" then
        if scancode == "escape" then
            love.event.quit()
        end
    end

    --< Gerer la pause >--
    if scancode == "p" or scancode == "escape" then        
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