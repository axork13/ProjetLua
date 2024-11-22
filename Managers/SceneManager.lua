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

function SceneManager:draw()
    self.currentScene:draw()
end

function SceneManager:keypressed(key)
    if key == "g" then
        self:switchScene("Game")
    end

    if key == "m" then
        self:switchScene("Menu")
    end
end

function SceneManager:switchScene(pSceneType)
    self.currentScene = self.lstScene[pSceneType]
end

return SceneManager