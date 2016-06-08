local Path = string.sub(..., 1, -string.len(".shapes.text"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local SText = Class("shape.text",SBase)

function SText:initialize(text, x, y, limit, align)
  SBase.initialize(self)
  self.t = text or "<text>"
  self.x = x or 0
  self.y = y or 0
  self.l = limit
  self.a = align
end

function SText:getType()
  return "text"
end

function SText:getDType(font)
  return "text", self.t, self.x, self.y, self.l, self.a
end

function SText:setProperties(text, x, y, limit, align)
  self.t = text or self.t
  self.x = x or self.x
  self.y = y or self.y
  self.l = limit or self.l
  self.a = align or self.a
end

function SText:getProperties()
  return self.t, self.x, self.y, self.l, self.a
end

function SText:computeAABB()
  return self.x, self.y, self.x+self.l, self.y
end

function SText:testShape(px,py)
  local x, y, xw, xh = self:computeAABB()
  if px > x and px < xw and py > y and py < yh then
    return true
  else
    return false
  end
end

return SText