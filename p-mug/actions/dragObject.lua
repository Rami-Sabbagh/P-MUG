local Path = string.sub(..., 1, -string.len(".actions.dragObject"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")

local ADO = Class("action.dragObject",ABase)

function ADO:initialize()
  ABase.initialize(self)
  self.obstructed = {}
end

function ADO:handlerDown(x,y,pressure,obj,shape,shapes,obstruct)
  if obstruct then self.obstructed[obj] = true elseif self.obstructed[obj] then self.obstructed[obj] = nil end
end

function ADO:handlerDragged(x,y,dx,dy,obj,shape,shapes,obstruct)
  if self.obstructed[obj] then return end
  local oldx, oldy = obj:getPosition()
  obj:setPosition(oldx+dx, oldy+dy)
end

function ADO:handlerReleased(x,y,pressure,obj,shape,shapes,obstruct)
  if self.obstructed[obj] then self.obstructed[obj] = nil end
end

return ADO