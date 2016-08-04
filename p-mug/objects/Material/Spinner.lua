local Path = string.sub(..., 1, -string.len(".objects.Material.Spinner"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local OSpinner = Class("object.spinner",OBase)

function OSpinner:initialize(x,y,radius,width,speed,precision)
  OBase.initialize(self) local PMug = require(Path)
  self.r, self.w, self.s, self.p = radius or 28, width or 3, speed or 1, precision or 100

  --Shapes--
  self.SSpinner = PMug.Shape.spinner(0, 0, self.r, self.w, self.s, self.p)

  --Drawers--
  self.Drawer = PMug.Drawer.material()

  --Registering--
  self.Drawer:linkShape(self.SSpinner)
  self:registerShape(self.SSpinner):addDrawer(self.Drawer)

  self:setPosition(x,y)
end

function OSpinner:getType()
  return "Spinner"
end

return OSpinner
