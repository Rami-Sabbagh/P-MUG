local Path = string.sub(..., 1, -string.len(".actions.dragObject"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")

local ADO = Class("action.onClick",ABase)

function ADO:handlerDragged(x,y,dx,dy,obj,shape,shapes,obstruct)
  if obstruct then return end
  local oldx, oldy = obj:getPosition()
  obj:setPosition(oldx+dx, oldy+dy)
end

return ADO