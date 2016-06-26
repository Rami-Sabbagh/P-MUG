local Path = string.sub(..., 1, -string.len(".drawers.material"))
local Class = require(Path..".third-party.middleclass")
local DBase = require(Path..".api.drawerbase")

local Material = require(Path..".third-party.material-love")

local DMaterial = Class("drawer.material",DBase)

local Config = {}
Config.rectangleExpand = 1 --How much to expand the rectangle when it's down ?

--[[
Drawing Args:
  rectangle shapes:
    DShadow, DExpand, RColor, NColor, HColor
      DShadow: boolean: To disable the shadow or not.
      DExpand: boolean: To disable the expand affect or not.
      RColor: table: {red,green,blue,alpha} The color of the ripple.
      NColor: table: {red,green,blue,alpha} The color of the rectangle when not hovered.
      HColor: table: {red,green,blue,alpha} The color of the rectangle when hovered.
   
  text shapes:
    FontType, FontColor
      FontType: string: The type of the material robot font to use.
      FontColor: table: {red,green,blue,alpha} The color of the text.
]]

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

function DMaterial:draw_rectangle(shape,obj)
  local dtype, x, y, w, h = shape:getDType()
  local DShadow, DExpand, RColor, NColor, HColor = shape:getDrawingArgs()
  if not self.sd[shape] then
    self.sd[shape] = {}
    self.sd[shape].rstarted = false
    self.sd[shape].rbox = Material.ripple.box(x-Config.rectangleExpand,y-Config.rectangleExpand,w+Config.rectangleExpand*2,h+Config.rectangleExpand*2,0.5)
  end
  
  local isDown, dx, dy = shape:isDown()
  local isHovered = shape:isHovered()
  if isDown and not DExpand then x,y,w,h = x-Config.rectangleExpand,y-Config.rectangleExpand,w+Config.rectangleExpand*2,h+Config.rectangleExpand*2 end
  if isDown then
    if not self.sd[shape].rstarted then
      local r = self.sd[shape].rbox r.box.x, r.box.y, r.box.w, r.box.h = x,y,w,h r:start(dx,dy, unpack(RColor or {Material.colors.main("blue")})) self.sd[shape].rstarted = true
    end
  else
    if self.sd[shape].rstarted then
      local r = self.sd[shape].rbox r.box.x, r.box.y, r.box.w, r.box.h = x,y,w,h r:fade() self.sd[shape].rstarted = false
    end
  end
  
  if isHovered then
    love.graphics.setColor(HColor or {Material.colors("grey","100")})
  else
    love.graphics.setColor(NColor or {Material.colors.main("white")})
  end
  
  love.graphics.setLineWidth(1)
  
  local _, _, z = obj:getPosition()
  if z and not DShadow then
    z = math.floor(z+0.5) if z > 4 then z = 4 end
    if isDown then Material.shadow.draw(x,y,w,h,false,z+1)
    elseif z > 0 then Material.shadow.draw(x,y,w,h,false,z) end
  end
  
  love.graphics.rectangle("fill",x,y,w,h)
  love.graphics.rectangle("line",x,y,w,h)
  
  self.sd[shape].rbox:draw()
end

function DMaterial:draw_text(shape,obj)
  local fonttype, fontcolor = shape:getDrawingArgs()
  local dtype, t, x, y, l, a = shape:getDType(Material.roboto[fonttype or "button"])
  love.graphics.setColor(fontcolor or {Material.colors.mono("black","button")})
  love.graphics.setLineWidth(1)
  love.graphics.setFont(Material.roboto[fonttype or "button"])
  love.graphics.printf(t, x, y, l, a)
end

function DMaterial:draw_icon(shape,obj)
  local dtype, icon, x,y, rotation, color, active, invert = shape:getDType()
  Material.icons.draw(icon, x,y, rotation, color, active, invert)
end

return DMaterial