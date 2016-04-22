local Path = string.sub(..., 1, string.len(...) - string.len(".themes.Flat.UI"))
local Color = require(Path..".themes.Flat.Color")
local FlatUI = {}

FlatUI["shape.Rectangle"] = {}
FlatUI["shape.Rectangle"].draw = function(self,object,incolor,outcolor,thickness)
  local incolor = incolor or {255,255,255,255}
  if object.down then local r,g,b,a = Color.darken(incolor[1],incolor[2],incolor[3],incolor[4],30) incolor = {r,g,b,a}
  elseif object.hover then local r,g,b,a = Color.darken(incolor[1],incolor[2],incolor[3],incolor[4],15) incolor = {r,g,b,a} end
  love.graphics.setColor(incolor)
  love.graphics.rectangle("fill",self:getProperties())
  if outcolor then
    if object.down then local r,g,b,a = Color.darken(outcolor[1],outcolor[2],outcolor[3],outcolor[4],30) outcolor = {r,g,b,a}
    elseif object.hover then local r,g,b,a = Color.darken(outcolor[1],outcolor[2],outcolor[3],outcolor[4],15) outcolor = {r,g,b,a} end
    love.graphics.setColor(outcolor)
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(thickness or 1)
    love.graphics.rectangle("line",self:getProperties())
  end
end

FlatUI["shape.Line"] = {}
FlatUI["shape.Line"].draw = function (self,object,color)
  local incolor = color or {0,0,0,255}
  if object.down then local r,g,b,a = Color.darken(color[1],color[2],color[3],color[4],30) color = {r,g,b,a}
  elseif object.hover then local r,g,b,a = Color.darken(color[1],color[2],color[3],color[4],15) color = {r,g,b,a} end
  local sx,sy,ex,ey,tn = self:getProperties()
  love.graphics.setColor(color)
  love.graphics.setLineStyle("rough")
  love.graphics.setLineWidth(tn)
  love.graphics.line(sx,sy,ex,ey)
end

return FlatUI