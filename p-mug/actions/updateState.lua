local Path = string.sub(..., 1, -string.len(".actions.updateState"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")


local AUS = Class("action.updateState",ABase)

function AUS:handlerHovering(x,y,obj,shapes)
  
end

function AUS:handlerUnhovered(x,y,obj,shapes)
  
end

function AUS:handlerDown(x,y,pressure,obj,shapes)
  for k,shp in ipairs(shapes) do
    shp:isDown(true,x,y)
  end
end

function AUS:handlerDragged(x,y,dx,dy,obj,shapes)
  
end

function AUS:handlerReleased(x,y,pressure,obj,shapes)
  for k,shp in ipairs(shapes) do
    shp:isDown(false,x,y)
  end
end

function AUS:handlerCancelled(x,y,pressure,shapes)
  for k,shp in ipairs(shapes) do
    shp:isDown(false,x,y)
  end
end

return AUS