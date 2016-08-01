local Path = string.sub(..., 1, -string.len(".actions.slideShape"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")

local ADO = Class("action.dragObject",ABase)

function ADO:initialize(x,y,length,orientation,slideShape,onSlide)
  ABase.initialize(self)
  self.obstructed = {}
  self.sX, self.sY, self.sL, self.sO, self.sS = x or 0, y or 0, length or 100, orientation or "h", slideShape
  self.onSlide = onSlide or function(shape,obj,newX,newY) end
end

function ADO:setOnSlide(onSlide)
  self.onSlide = onSlide or function(shape,obj,newX,newY) end
end

function ADO:handlerDown(x,y,pressure,obj,shape,shapes,obstruct)
  if obstruct then self.obstructed[obj] = true elseif self.obstructed[obj] then self.obstructed[obj] = nil end
end

function ADO:handlerDragged(x,y,dx,dy,obj,shape,shapes,obstruct)
  if self.obstructed[obj] then return end
  if self.sS and not shape == self.sS then return end
  local oldx, oldy = shape:getProperties()
  if self.sO == "h" then
    local newx, newy = x, self.sY
    if newx < self.sX then newx = self.sX elseif newx > self.sX+self.sL then newx = self.sX+self.sL end
    shape:setProperties(newx,newy)
    if oldx ~= newx or oldy ~= newy then self.onSlide(shape,obj,newx,newy) end
  elseif self.sO == "v" then
    local newx, newy = self.sX, y
    if newy < self.sY then newy = self.sY elseif newy > self.sY+self.sL then newy = self.sY+self.sL end
    shape:setProperties(newx,newy)
    if oldx ~= newx or oldy ~= newy then self.onSlide(shape,obj,newx,newy) end
  end
end

function ADO:handlerReleased(x,y,pressure,obj,shape,shapes,obstruct)
  if self.obstructed[obj] then self.obstructed[obj] = nil end
end

return ADO
