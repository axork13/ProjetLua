--<====== Classe permettant de créer un vecteur ======>--
local Vector2 = {}

--< Constructeur >--
function Vector2:new(pX, pY)
    local v = {}

    v.x = pX or 0
    v.y = pY or 0

    setmetatable(v, self)
    self.__index = self

    -- Addition de deux vecteurs
    self.__add = function(pV)
        return Vector2:new(v.x+pV.x, v.y+pV.y)
    end

    -- Soustraction de deux vecteurs
    self.__sub = function(pV)
        return Vector2:new(v.x-pV.x, v.y-pV.y)
    end

    -- Vecteur inverse (operateur unaire)
    self.__unm = function(pV)
        return Vector2:new(-pV.x, -pV.y)
    end

    -- Multiplication par un scalaire
    self.__mul = function(k, pV)
        local vec = Vector2:new()

        if type(k) == "number" then
            vec = Vector2:new(pV.x * k, pV.y * k)
        else
            vec = Vector2:new(k.x * pV, k.y * pV)
        end

        return vec
    end

    return v
end

function Vector2:norm()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector2:normalize()
    local n = self:norm()

    if(n == 0) then
        self.x = 0
        self.y = 0
    else
        self.x = self.x / n
        self.y = self.y / n
    end
end

function Vector2:toString()
    print(self.x.." - "..self.y)
end
return Vector2