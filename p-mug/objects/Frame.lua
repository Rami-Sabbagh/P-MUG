local Path = string.sub(..., 1, -string.len(".objects.frame"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local OFrame = Class("object.frame",OBase)

function OFrame:initialize(x,y,w,h,design,t)
  OBase.initialize(self)
  local PMug = require(Path)
  
  --Actions--
  self.SetToTopAction = PMug.Action.updateState(true,true,false)
  self.DragAction = PMug.Action.dragObject()
  self.CloseAction = PMug.Action.onClick(function() self:destroy() end)
  
  PMug.buildObject(self,design,x,y,w,h,t)
  
  self:setPosition(x,y)
end

function OFrame:getType()
  return "Frame"
end

function OFrame:registerObject(obj,z)
  return self.FrameContainer:registerObject(obj,z)
end

return OFrame