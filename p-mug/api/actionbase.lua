local Path = string.sub(..., 1, -string.len(".api.handlerbase"))
local Class = require(Path..".third-party.middleclass")

local ABase = Class("action.base") ABase.PMUGA = true --P-Mug Action Class

function ABase:initialize()
  
end

function ABase:update(dt)
  
end

function ABase:handlerHovered()
  
end

function ABase:handlerDown()

end

function ABase:handlerDragged()
  
end

function ABase:handlerReleased()
  
end

function ABase:handlerCanceled()
  
end

return ABase