--<====== Ensemble des fonctions utiles pour le jeu ======>--

-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function checkAABBCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

function drawCollideBox(x, y, width, height)
    love.graphics.setColor(1, 0, 0, 1) -- Couleur rouge pour la boîte
    love.graphics.rectangle("line", x, y, width, height) -- Dessine un rectangle en mode ligne
    love.graphics.setColor(1, 1, 1, 1) -- Réinitialise la couleur à blanc
end