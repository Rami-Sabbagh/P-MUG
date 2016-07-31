local Path = string.sub(..., 1, -string.len(".objects.Slider"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local OSlider = Class("object.slider",OBase)

function OSlider:initialize(x,y,length,design,orientation,min,max)
  OBase.initialize(self)
  local PMug = require(Path)

  --Actions--
  self.DragAction = PMug.Action.dragObject()

  self:setPosition(x,y)
end

function OSlider:getType()
  return "Slider"
end

return OSlider
