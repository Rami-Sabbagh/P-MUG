local Path = string.sub(..., 1, -string.len(".objects.Text"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local OText = Class("object.text",OBase)

function OText:initialize(t,x,y,w,h,design)
  OBase.initialize(self)
  local PMug = require(Path)
  
  PMug.buildObject(self,design,t,x,y,w,h)
  
  self:setPosition(x,y)
end

function OText:getType()
  return "Text"
end

function OText:setText(t)
  self.SText:setProperties(t)
end

return OText