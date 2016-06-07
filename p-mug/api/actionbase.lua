local Path = string.sub(..., 1, -string.len(".api.handlerbase"))
local Class = require(Path..".third-party.middleclass")

local ABase = Class("action.base") ABase.PMUGA = true --P-Mug Action Class

function ABase:initialize()
    self.hd = {} --Handlerdata, Table used by the handler to handle some stuff.
end

function ABase:update(dt)
  
end

function ABase:handlerHovering(x,y)
  
end

function ABase:handlerUnhovered(x,y)
  
end

function ABase:handlerDown(x,y,pressure)
  
end

function ABase:handlerDragged(x,y,pressure)
  
end

function ABase:handlerReleased(x,y,pressure)
  
end

function ABase:handlerCancelled(x,y,pressure)
  
end

return ABase