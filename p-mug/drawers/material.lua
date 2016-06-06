local Path = string.sub(..., 1, -string.len(".drawers.material"))
local Class = require(Path..".third-party.middleclass")
local DBase = require(Path..".api.drawerbase")

local Material = require(Path..".third-party.material-love")

local DMaterial = Class("drawer.material",DBase)

function DMaterial:initialize()
  DBase.initialize(self)
  self.sd = {}
end

function DMaterial:getName()
  return "Material"
end

function DMaterial:update(dt)
  for shp, v in pairs(self.sd) do
    if v.rbox then v.rbox:update(dt) end
  end
end

function DMaterial:draw_rectangle(shape)
  local e = 3
  local x, y, w, h = shape:getDrawingArgs()
  if not self.sd[shape] then
    self.sd[shape] = {}
    self.sd[shape].rstarted = false
    self.sd[shape].rbox = Material.ripple.box(x-e,y-e,w+e+e,h+e+e,0.5)
  end
  
  local isDown, dx, dy = shape:isDown()
  if isDown then x,y,w,h = x-e,y-e,w+e+e,h+e+e end
  if isDown then
    if not self.sd[shape].rstarted then
      local r = self.sd[shape].rbox
      r.box.x, r.box.y, r.box.w, r.box.h = x,y,w,h
      r:start(dx,dy, Material.colors.main("blue"))
      self.sd[shape].rstarted = true
    end
  else
    if self.sd[shape].rstarted then
      local r = self.sd[shape].rbox
      r.box.x, r.box.y, r.box.w, r.box.h = x,y,w,h
      r:fade()
      self.sd[shape].rstarted = false
    end
  end
  
  love.graphics.setColor(Material.colors.main("white"))
  love.graphics.setLineWidth(1)
  
  Material.shadow.draw(x,y,w,h,false,isDown and 3 or 2)  
  
  love.graphics.rectangle("fill",x,y,w,h)
  love.graphics.rectangle("line",x,y,w,h)
  
  self.sd[shape].rbox:draw()
end

function DMaterial:draw_text(shape)
  love.graphics.setColor(Material.colors.mono("black","button"))
  love.graphics.setLineWidth(1)
  love.graphics.setFont(Material.roboto.button)
  love.graphics.printf(shape:getDrawingArgs(Material.roboto.button))
end

return DMaterial