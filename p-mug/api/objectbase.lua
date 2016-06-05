local Path = string.sub(..., 1, string.len(...) - string.len(".api.objectbase"))
local Class = require(Path..".third-party.middleclass")

local OBase = Class("object.base") OBase.PMUGO = true --P-Mug Object Class

function OBase:initialize()
  self.drawers = {}
  self.shapes = {}
end

function OBase:addDrawer(drawer)
  if not drawer.PMUGD then return error("This isn't a P-Mug drawer class") end
  table.insert(self.drawers,drawer)
  return self,#self.drawers
end

function OBase:addBhavior()
  
end

function OBase:registerShape(shape)
  if not shape.PMUGS then return error("This isn't a P-Mug shape class") end
  table.insert(self.shapes,shape)
  return self,#self.shapes
end

function OBase:draw()
  for i=1,#self.drawers do
    if self.drawers[i].draw then self.drawers[i]:draw() end
  end
end

function OBase:update(dt)
  for i=1,#self.shapes do
    if self.shapes[i].update then self.shapes[i]:update(dt) end
  end
  
  for i=1,#self.drawers do
    if self.drawers[i].update then self.drawers[i]:update(dt) end
  end
end

return OBase