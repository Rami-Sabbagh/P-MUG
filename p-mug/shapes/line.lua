local Path = string.sub(..., 1, -string.len(".shapes.line"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local SLine = Class("shape.line",SBase)

function SLine:initialize(x1,y1,x2,y2,width)
  SBase.initialize(self)
  self.x1, self.y1, self.x2, self.y2, self.width = x1 or 0, y1 or 0, x2 or 0, y2 or 0, width or 3
end

function SLine:getType()
  return "line"
end

function SLine:getDType()
  return "line", self.x1, self.y1, self.x2, self.y2, self.width
end

function SLine:setProperties(x1,y1,x2,y2,width)
  self.x1 = x1 or self.x1
  self.y1 = y1 or self.y1
  self.x2 = x2 or self.x2
  self.y2 = y2 or self.y2
  self.width = width or self.width
end

function SLine:getProperties()
  return self.x1, self.y1, self.x2, self.y2, self.width
end

function SLine:computeAABB()
  return self.x1 < self.x2 and self.x1 or self.x2, self.y1 < self.y2 and self.y1 or self.y1,
  (self.x1 > self.x2 and self.x1 or self.x2) - (self.x1 < self.x2 and self.x1 or self.x2),
  (self.y1 > self.y2 and self.y1 or self.y1) - (self.y1 < self.y2 and self.y1 or self.y1)
end

local function calcDistance(x1,y1,x2,y2)
  return math.sqrt((x1-x2)^2+(y1-y2)^2)
end

function SLine:testShape(px, py)
  local lineDist = calcDistance(self.x1, self.y1, self.x2, self.y2)
  local p1Dist = calcDistance(self.x1, self.y1, px, py)
  local p2Dist = calcDistance(self.x2, self.y2, px, py)
  local pDist = p1Dist + p2Dist
  if pDist <= lineDist + self.width then return true else return false end
end

return SLine
