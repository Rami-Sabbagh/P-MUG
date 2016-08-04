local Path = string.sub(..., 1, -string.len(".shapes.spinner"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local SSpinner = Class("shape.spinner",SBase)

function SSpinner:initialize(x,y,radius,width,speed,precision)
  SBase.initialize(self)
  self.x = x or 0
  self.y = y or 0
  self.r = radius or 28
  self.w = width or 3
  self.s = speed or 0
  self.p = precision or 100
end

function SSpinner:getType()
  return "spinner"
end

function SSpinner:getDType()
  return "spinner", self.x, self.y, self.r, self.w, self.s, self.p
end

function SSpinner:setProperties(x, y, radius, width, speed, precision)
  self.x = x or self.x
  self.y = y or self.y
  self.r = radius or self.r
  self.w = width or self.w
  self.s = speed or self.s
  self.p = precision or self.p
end

function SSpinner:getProperties()
  return self.x, self.y, self.r, self.w, self.s, self.p
end

function SSpinner:computeAABB()
  return self.x-self.r, self.y-self.r, self.x+self.r, self.y+self.r
end

function SSpinner:testShape(px,py)
  return false --The spinner is a styling shape, so it shouldn't be used for testing points..
end

return SSpinner