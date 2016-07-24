local Path = string.sub(..., 1, -string.len(".api.actionbase"))
local Class = require(Path..".third-party.middleclass")

local ABase = Class("action.base") ABase.PMUGA = true --P-Mug Action Class

function ABase:initialize()
    self.hd = {} --Handlerdata, Table used by the handler to handle some stuff.
end

function ABase:update(dt,obj,shapes)
  --Normal love.update callback
end

function ABase:keypressed(key,scancode,isrepeat,flag,obj)
  --Called when a key get pressed.
end

function ABase:keyreleased(key,scancode,flag,obj)
  --Called when a key get released.
end

function ABase:textinput(text,flag,obj)
  --Called when the user inputs text.
end

function ABase:selected()
  
end

function ABase:deselected()
  
end

function ABase:handlerHovering(x,y,dx,dy,obj,shape,shapes,obstruct)
  --Called when the shapes linked with the handler are hovered.
end

function ABase:handlerUnhovered(x,y,dx,dy,obj,shapes,obstruct)
  --Called when a linked shape in the handler is unhovered.
end

function ABase:handlerDown(x,y,pressure,obj,shape,shapes,obstruct)
  --Called when a linked shape in the handler is clicked down.
end

function ABase:handlerDragged(x,y,dx,dy,obj,shape,shapes,obstruct)
  --Called when a linked shape in the handler is clicked down and dragged.
end

function ABase:handlerReleased(x,y,pressure,obj,shape,shapes,obstruct)
  --Called when a linked shape in the handler is released inside the shape.
end

function ABase:handlerCancelled(x,y,pressure,obj,shape,shapes,obstruct)
  --Called when a linked shape in the handler is released outside of the shape.
end

return ABase