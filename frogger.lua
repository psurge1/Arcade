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
  p = {},
  safety = "",
  danger = "",
  basesquare = ""
}

function MapM:new(o, x, y)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.x = x
  self.y = y
  self.map = {}
  self.p = {1, 1}
  self.safety = ""
  self.danger = ""
  self.basesquare = ""
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

function MapM:GetSafety()
  return self.safety
end

function MapM:SetSafety(s)
  self.safety = s
end

function MapM:GetDanger()
  return self.danger
end

function MapM:SetDanger(s)
  self.danger = s
end

function MapM:GetBaseSquare()
  return self.basesquare
end

function MapM:SetBaseSquare(s)
  self.basesquare = s
end

function MapM:GetLocation()
  return self.p
end

function MapM:SetLocation(px, py)
  self.p[1] = px
  self.p[2] = py
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
  self.map[self.p[2]][self.p[1]] = self.basesquare
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
      self:Win()
      break
    elseif self.map[self.p[2]][self.p[1]] == self.danger then
      self:Loss()
      break
    end
    self:Dispmap()
    self:Move(io.read(), 1)
  end
end

function MapM:IsValid(n, m)
  if n >= 1 and n <= self.x and m >= 1 and m <= self.y then
    if self.map[m][n] == self.safety or self.map[m][n] == self.danger then
      return true
    end
  end
  return false
end

function MapM:jump(n)
  local temp = self.p[2] - 2
  if self:IsValid(self.p[1], temp) then
    self.p[2] = temp
  end
end

function MapM:up(n)
  local temp = self.p[2] - 1
  if self:IsValid(self.p[1], temp) then
    self.p[2] = temp
  end
end

function MapM:down(n)
  local temp = self.p[2] + 1
  if self:IsValid(self.p[1], temp) then
    self.p[2] = temp
  end
end

function MapM:left(n)
  local temp = self.p[1] - 1
  if self:IsValid(temp, self.p[2]) then
    self.p[1] = temp
  end
end

function MapM:right(n)
  local temp = self.p[1] + 1
  if self:IsValid(temp, self.p[2]) then
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
  elseif d == "j" then
    self:jump(n)
  end
end

function MapM:Win()
  print("won")
end

function MapM:Loss()
  print("lost")
end

return {MapM = MapM}