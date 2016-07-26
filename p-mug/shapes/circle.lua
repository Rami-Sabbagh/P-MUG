local Path = string.sub(..., 1, -string.len(".shapes.circle"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local SCircle = Class("shape.circle",SBase)

function SCircle:initialize(x,y,radius)
  SBase.initialize(self)
  self.x = x or 0
  self.y = y or 0
  self.r = radius or 0
end

function SCircle:getType()
  return "circle"
end

function SCircle:getDType()
  return "circle", self.x, self.y, self.r
end

function SCircle:setProperties(x,y,radius)
  self.x = x or self.x
  self.y = y or self.y
  self.r = radius or self.r
end

function SCircle:getProperties()
  return self.x, self.y, self.w, self.h
end

function SCircle:computeAABB()
  return self.x-self.r, self.y-self.r, self.x+self.r, self.y+self.r
end

function SCircle:testShape(px,py)
  local distance = math.sqrt((px-self.x)^2+(py-self.y)^2)
  if distance <= self.r then
    return true
  else
    return false
  end
end

return SCircle