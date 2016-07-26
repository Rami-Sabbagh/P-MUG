local Path = string.sub(..., 1, -string.len(".objects.Button"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local OButton = Class("object.button",OBase)

function OButton:initialize(x,y,w,h,design,t,oc)
  OBase.initialize(self)
  local PMug = require(Path)
  self.onClick = PMug.Action.onClick(oc)
  
  PMug.buildObject(self,design,x,y,w,h,t)
  
  self:setPosition(x,y)
end

function OButton:getType()
  return "Button"
end

function OButton:setOnClick(oc)
  self.onClick:setOnClick(oc)
end

return OButton