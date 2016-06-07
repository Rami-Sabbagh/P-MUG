local Path = string.sub(..., 1, -string.len(".api.handlerbase"))
local Class = require(Path..".third-party.middleclass")

local ABase = Class("action.base") ABase.PMUGA = true --P-Mug Action Class

function ABase:initialize()
    self.hd = {} --Handlerdata, Table used by the handler to handle some stuff.
end

function ABase:update(dt,obj,shapes)
  
end

function ABase:handlerHovering(x,y,dx,dy,obj,shape,shapes)
  
end

function ABase:handlerUnhovered(x,y,dx,dy,obj,shapes)
  
end

function ABase:handlerDown(x,y,pressure,obj,shape,shapes)
  
end

function ABase:handlerDragged(x,y,dx,dy,obj,shape,shapes)
  
end

function ABase:handlerReleased(x,y,pressure,obj,shape,shapes)
  
end

function ABase:handlerCancelled(x,y,pressure,obj,shape,shapes)
  
end

return ABase