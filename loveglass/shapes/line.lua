local Path = string.sub(..., 1, string.len(...) - string.len(".shapes.line"))
local Class = require(Path .. ".third-party.middleclass")
local SBase = require(Path .. ".shapes.base")

local MathUtil = require(Path .. ".libraries.MathUtil")

local SLine = Class("shape.Line",SBase)

function SLine:initialize(startX,startY,endX,endY,thickness)
  self.sX = startX or 0
  self.sY = startY or 0
  self.eX = endX or 0
  self.eY = endY or 0
  self.tn = thickness or 5
end

function SLine:getContainingRect()
  return self.sX, self.sY, self.eX-self.sX, self.eY-self.sY
end

function SLine:setProperties(startX,startY,endX,endY,thickness)
  self.sX = startX or self.sX
  self.sY = startY or self.sY
  self.eX = endX or self.eX
  self.eY = endY or self.eY
  self.tn = thickness or self.tn
end

function SLine:getProperties()
  return self.sX, self.sY, self.eX, self.eY, self.tn
end

function SLine:drawDebug(color)
  love.graphics.setColor(color)
  love.graphics.setLineWidth(self.tn)
  love.graphics.line(self.sX,self.sY,self.eX,self.eY)
end

function SLine:isInUI(x,y,pressure)
  local d1 = MathUtil.calcDistance(self.sX,self.sY,x,y)
  local d2 = MathUtil.calcDistance(self.eX,self.eY,x,y)
  local d = MathUtil.calcDistance(self.sX,self.sY,self.eX,self.eY)
  
  if d1+d2 < d+(self.tn/2) and d1+d2 > d-(self.tn/2) then
    return true
  else
    return false
  end
end

return SLine