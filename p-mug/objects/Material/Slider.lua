local Path = string.sub(..., 1, -string.len(".objects.Material.Slider"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local Material = require(Path..".third-party.material-love")

local OSlider = Class("object.slider",OBase)

function OSlider:initialize(x,y,length,orientation,min,max)
  OBase.initialize(self)
  local PMug = require(Path)

  --Shapes--
  self.SCircle = PMug.Shape.circle(0,0,10):setDrawingArgs(true,true,{0,0,0,0},{Material.colors.main("blue-grey")},{Material.colors.main("light-blue")})

  --Actions--
  self.slideAction = PMug.Action.slideShape(0,0,length,orientation,self.SCircle)
  self.updateStateAction = PMug.Action.updateState()

  --Drawers--
  self.Drawer = PMug.Drawer.material()

  --Handlers--
  self.Handler = PMug.Handler()

  --Registering--
  self:addHandler(self.Handler):addDrawer(self.Drawer)

  self.Handler:linkShape(self.SCircle):addAction(self.slideAction):addAction(self.updateStateAction)
  self.Drawer:linkShape(self.SCircle)

  self:registerShape(self.SCircle)

  self:setPosition(x,y)
end

function OSlider:getType()
  return "Slider"
end

return OSlider
