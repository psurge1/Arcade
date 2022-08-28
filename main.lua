local frogger = require("frogger")
local ataribreakout = require("ataribreakout")
local pong = require("pong")
local spaceinvaders = require("spaceinvaders")

math.randomseed(os.time())


-- frogger
local w = 10
local h = 10
local tiles = {}
tiles['A'] = 10
tiles['X'] = 10
tiles['L'] = 80
Map = frogger.MapM:new()
Map:setX(w)
Map:setY(h)
Map:Genmap(tiles)
-- Map = Genmap(w, h, SortT(tiles))
Map:Play()
Map:Dispmap()

-- ataribreakout


-- pong


-- spaceinvaders

