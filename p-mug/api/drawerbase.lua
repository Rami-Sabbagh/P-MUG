local Path = string.sub(..., 1, -string.len(".api.drawerbase"))
local Class = require(Path..".third-party.middleclass")

local DBase = Class("drawer.base") DBase.PMUGD = true --P-Mug Drawer Class

function DBase:initialize()
  self.LShapes = {} --The linked shapes.
end

function DBase:getName()
  return "Base"
end

function DBase:linkShape(shp)
  if not shp.PMUGS then return error("This isn't a P-Mug shape class") end
  table.insert(self.LShapes,shp)
  return self, #self.LShapes
end

function DBase:draw(obj,drawStencil)
  for k,S in ipairs(self.LShapes) do
    local T = S:getDType()
    if S:isVisible() then
      if drawStencil then
        if self["stencil_"..T] then self["stencil_"..T](self,S,obj) end
      else
        if self["draw_"..T] then self["draw_"..T](self,S,obj) end
      end
    end
  end
end

function DBase:update(dt,obj)

end

return DBase
