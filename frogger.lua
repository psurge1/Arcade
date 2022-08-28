-- function SortT(t)
  
-- end

function CheckC(t)
  local s = 0
  for key in pairs(t) do
    s = s + t[key]
  end
  return s == 100
end

function Chanced(t)
  local r = math.random(0, 100)
  local s = 0
  for key, value in pairs(t) do
    if r <= value + s then
      return key
    else
      s = value + s
    end
  end
end

MapM = {
  x = 0,
  y = 0,
  map = {},
  p = {}
}

function MapM:new(o, x, y)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.x = x
  self.y = y
  self.map = {}
  self.p = {1, 1}
  return o
end

function MapM:setX(x)
  self.x = x
end

function MapM:getX()
  return self.x
end

function MapM:setY(y)
  self.y = y
  self.p = {1, y}
end

function MapM:getY()
  return self.y
end

function MapM:Genmap(chances)
  if not CheckC(chances) then
    return {}
  end
  self.map = {}
  for i = 0, self.y, 1 do
    self.map[i] = {}
    for k = 0, self.x, 1 do
      self.map[i][k] = Chanced(chances)
    end
  end
end

function MapM:Dispmap()
  local disp = io.write
  for b in ipairs(self.map) do
    for a in ipairs(self.map[b]) do
      -- disp(a .. " " .. b .. " ")
      if a == self.p[1] and b == self.p[2] then
        disp(self.map[b][a] .. "+ ")
      else
        disp(self.map[b][a] .. "  ")
      end
    end
    disp("\n")
  end
end

function MapM:Play()
  while true do
    for i = 1, 100 do
      print()
    end
    if self.p[2] == 1 then
      break
    end
    self:Dispmap()
    self:Move(io.read(), 1)
  end
end

function MapM:IsValidX(n)
  return n > 0 and n <= self.x
end

function MapM:IsValidY(n)
  return n > 0 and n <= self.y
end

function MapM:up(n)
  local temp = self.p[2] - 1
  if self:IsValidY(temp) then
    self.p[2] = temp
  end
end

function MapM:down(n)
  local temp = self.p[2] + 1
  if self:IsValidY(temp) then
    self.p[2] = temp
  end
end

function MapM:left(n)
  local temp = self.p[1] - 1
  if self:IsValidX(temp) then
    self.p[1] = temp
  end
end

function MapM:right(n)
  local temp = self.p[1] + 1
  if self:IsValidX(temp) then
    self.p[1] = temp
  end
end

function MapM:Move(d, n)
  if d == "u" then
    self:up(n)
  elseif d == "d" then
    self:down(n)
  elseif d == "l" then
    self:left(n)
  elseif d == "r" then
    self:right(n)
  end
end

return {MapM = MapM}