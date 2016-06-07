local Path = string.sub(..., 1, -string.len(".actions.updateState"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")

local AUS = Class("action.updateState",ABase)

function AUS:initialize(skipDownState,skipHoverState)
  ABase.initialize(self)
  self.sds, self.shs = skipDownState, skipHoverState
end

function AUS:handlerHovering(x,y,dx,dy,obj,shape,shapes)
  if self.shs then return end
  for k,shp in ipairs(shapes) do
    shp:isHovered(true,x,y)
  end
end

function AUS:handlerUnhovered(x,y,dx,dy,obj,shapes)
  if self.shs then return end
  for k,shp in ipairs(shapes) do
    shp:isHovered(false,x,y)
  end
end

function AUS:handlerDown(x,y,pressure,obj,shape,shapes)
  if self.sds then return end
  for k,shp in ipairs(shapes) do
    shp:isDown(true,x,y)
  end
end

function AUS:handlerReleased(x,y,pressure,obj,shape,shapes)
  if self.sds then return end
  for k,shp in ipairs(shapes) do
    shp:isDown(false,x,y)
  end
end

function AUS:handlerCancelled(x,y,pressure,obj,shape,shapes)
  if self.sds then return end
  for k,shp in ipairs(shapes) do
    shp:isDown(false,x,y)
  end
end

return AUS