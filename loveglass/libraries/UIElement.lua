local Path = string.sub(..., 1, -string.len(".libraries.UIElement"))
local GlassUtil = require(Path..".libraries.GlassUtil")
local MathUtil = require(Path..".libraries.MathUtil")
local Class = require(Path .. ".third-party.middleclass")

local UIElement = Class("loveglass.UIElement") UIElement.static.LGUIE = true

function UIElement:initialize(name)
  self.Name = name
  self.UIShapes = {}
end

function UIElement:draw(object)
  for k,shape in ipairs(self.UIShapes) do
    shape:draw(object,unpack(shape:getDrawingArgs()))
  end
end

function UIElement:insertUIShape(shape)
  table.insert(self.UIShapes,shape)
  return self
end

function UIElement:setName(name)
  self.Name = name
  return self
end

function UIElement:getShapes()
  return self.UIShapes
end

function UIElement:getName()
  return self.Name
end

function UIElement:getRect()
  local Rects = {}
  for z = #self.UIShapes, 1, -1 do
    local shape = self.UIShapes[z]
    local x,y,w,h = shape:getContainingRect()
    local K = #Rects
    Rects[K+1] = x
    Rects[K+2] = y
    Rects[K+3] = w
    Rects[K+4] = h
  end
  return MathUtil.combineRects(unpack(Rects))
end

function UIElement:isInUI(x,y,pressure)
  for z = #self.UIShapes, 1, -1 do
    local shape = self.UIShapes[z]
    if shape:isInUI(x,y,pressure) then return true end
  end
  return false
end

return UIElement