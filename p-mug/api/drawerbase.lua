local Path = string.sub(..., 1, string.len(...) - string.len(".api.drawerbase"))
local Class = require(Path..".third-party.middleclass")

local DBase = Class("drawer.base") DBase.PMUGD = true --P-Mug Drawer Class

function DBase:initialize(name)
  self.DName = name --The drawer name.
  self.LShapes = {} --The linked shapes.
end

function DBase:getName()
  return self.DName
end

function DBase:linkShape(shp)
  if not shp.PMUGS then return error("This isn't a P-Mug shape class") end
end

function DBase:draw()
  
end

return DBase