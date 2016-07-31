local Path = string.sub(..., 1, -string.len(".shapes.spinner"))
local Class = require(Path..".third-party.middleclass")
local SBase = require(Path..".api.shapebase")

local SSpinner = Class("shape.spinner",SBase)

function SSpinner:initialize()
  SBase.initialize(self)

  
end

return SSpinner
