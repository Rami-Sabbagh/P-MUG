local Path = string.sub(..., 1, string.len(...) - string.len(".drawers.material"))
local Class = require(Path..".third-party.middleclass")
local DBase = require(Path..".api.drawerbase")

local Material = require(Path..".third-party.material-love")

local DMaterial = Class("drawer.material",DBase)

function DMaterial:initialize()
  DBase.initialize(self)
  self.SData = {}
end

function DMaterial:getName()
  return "Material"
end

function DMaterial:update(dt)
  
end

function DMaterial:draw_rectangle(shape)
  local x, y, w, h = shape:getDrawingArgs()
  if not self.SData[shape] then
    self.SData[shape] = Material.roundrect(x,y,w,h,3,3)
  end
  love.graphics.setColor(Material.colors.mono("white","full"))
  love.graphics.setLineWidth(1)
  love.graphics.polygon("fill", unpack(self.SData[shape]))
  love.graphics.polygon("line", unpack(self.SData[shape]))
  Material.shadow.draw(x,y,w,h)
  --love.graphics.rectangle("line", x, y, w, h)
end

function DMaterial:draw_text(shape)
  love.graphics.setColor(Material.colors.mono("black","button"))
  love.graphics.setLineWidth(1)
  love.graphics.setFont(Material.roboto.button)
  love.graphics.printf(shape:getDrawingArgs(Material.roboto.button))
end

return DMaterial