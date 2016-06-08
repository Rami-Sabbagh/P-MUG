local Path = string.sub(..., 1, -string.len(".shapes.rectangle"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local SRect = Class("shape.rectangle",SBase)

function SRect:initialize(x,y,width,height)
  SBase.initialize(self)
  self.x = x or 0
  self.y = y or 0
  self.w = width or 0
  self.h = height or 0
end

function SRect:getType()
  return "rectangle"
end

function SRect:getDType()
  return "rectangle", self.x, self.y, self.w, self.h
end

function SRect:setProperties(x,y,width,height)
  self.x = x or self.x
  self.y = y or self.y
  self.w = width or self.w
  self.h = height or self.h
end

function SRect:getProperties()
  return self.x, self.y, self.w, self.h
end

function SRect:computeAABB()
  return self.x, self.y, self.x+self.w, self.y+self.h
end

function SRect:testShape(px,py)
  local x, y, xw, yh = self:computeAABB()
  if px > x and px < xw and py > y and py < yh then
    return true
  else
    return false
  end
end

return SRect