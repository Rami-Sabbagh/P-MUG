local Path = string.sub(..., 1, -string.len(".shapes.rectangle"))
local Class = require(Path .. ".third-party.middleclass")
local SBase = require(Path .. ".shapes.base")

local SRectangle = Class("shape.Rectangle",SBase)

function SRectangle:initialize(x,y,width,height)
  self.x = x or 0
  self.y = y or 0
  self.w = width or 0
  self.h = height or 0
end

function SRectangle:getContainingRect()
  return self:getProperties()
end

function SRectangle:setProperties(x,y,width,height)
  self.x = x or self.x
  self.y = y or self.y
  self.w = width or self.w
  self.h = height or self.h
end

function SRectangle:getProperties()
  return self.x, self.y, self.w, self.h
end

function SRectangle:drawDebug(color)
  love.graphics.setColor(color)
  love.graphics.setLineWidth(3)
  love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
end

function SRectangle:isInUI(x,y,pressure)
  if x > self.x and y > self.y then
    if x < self.x+self.w and y < self.y+self.h then
      return true
    end
  end
  
  return false
end

return SRectangle