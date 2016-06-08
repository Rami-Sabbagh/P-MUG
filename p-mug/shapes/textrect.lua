local Path = string.sub(..., 1, -string.len(".shapes.textrect"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local STRect = Class("shape.textrect",SBase)

function STRect:initialize(text, x, y, width, height, align)
  SBase.initialize(self)
  self.t = text or "<text>"
  self.x = x or 0
  self.y = y or 0
  self.w = width or 0
  self.h = height or 0
  self.a = align
end

function STRect:getType()
  return "text"
end

function STRect:getDType(font)
  if not font then return "text" end
  local textheight = 0
  local width, wrappedtext = font:getWrap(self.t, self.w)
  for k, text in ipairs(wrappedtext) do
    textheight = textheight + font:getHeight(text)
  end
  return "text",self.t, self.x, self.y + (self.h - textheight)/2, self.w, self.a
end

function STRect:setProperties(text, x, y, width, height, align)
  self.t = text or self.t
  self.x = x or self.x
  self.y = y or self.y
  self.w = width or self.w
  self.h = height or self.h
  self.a = align or self.a
end

function STRect:getProperties()
  return self.t, self.x, self.y, self.w, self.h, self.a
end

function STRect:computeAABB()
  return self.x, self.y, self.x+self.w, self.y+self.h
end

function STRect:testShape(px,py)
  local x, y, xw, yh = self:computeAABB()
  if px > x and px < xw and py > y and py < yh then
    return true
  else
    return false
  end
end

return STRect