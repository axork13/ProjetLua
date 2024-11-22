JSON = require("/Libs.Json")

--<====== Classe permettant de gérer les langues de jeu ======>--
local LocaleManager = {}

function LocaleManager:new()
    local lm = {}

    lm.locale = {}
    lm.currentLanguage = "en"

    setmetatable(lm, self)
    self.__index = self
    return lm
end

function LocaleManager:load(pLang)
    local filename = "Locales/"..pLang..".json"
    local file = love.filesystem.read(filename)
    
    if file then
        self.locale = JSON.decode(file)
    else
        print("Langue non trouvée, chargement par défaut (anglais)")
        self.locale = JSON.decode(love.filesystem.read("Locales/en.json"))
    end
end

function LocaleManager:switchLanguage()
    if self.currentLanguage == "en" then
        self.currentLanguage = "fr"
    else
        self.currentLanguage = "en"
    end

    self:load(self.currentLanguage)
end

return LocaleManager