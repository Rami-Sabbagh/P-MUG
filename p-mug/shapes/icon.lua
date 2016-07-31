local Path = string.sub(..., 1, -string.len(".shapes.icon"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local SIcon = Class("shape.icon",SBase)

function SIcon:initialize(iconname, x, y, rotation, color, active, invert)
  SBase.initialize(self)
  self.cn = iconname or "alert-circle-outline"
  self.x, self.y, self.r = x or 0, y or 0, rotation or 0
  self.color = color or "black"
  self.active, self.invert = active, invert or "none"
end

function SIcon:getType()
  return "icon"
end

function SIcon:getDType()
  return "icon", self.cn, self.x, self.y, self.r, self.color, self.active, self.invert
end

function SIcon:setProperties(iconname, x, y, rotation, color, active, invert)
  self.cn = iconname or self.cn
  self.x, self.y, self.r = x or self.x, y or self.y, rotation or self.r
  self.color = color or self.color
  self.active, self.invert = active, invert or self.invert
end

function SIcon:getProperties()
  return self.cn, self.x, self.y, self.r, self.color, self.active, self.invert
end

function SIcon:computeAABB()
  return self.x, self.y, 0, 0
end

function SIcon:testShape(px,py)
  return false
end

return SIcon
