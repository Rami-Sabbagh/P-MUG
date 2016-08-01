local Path = string.sub(..., 1, -string.len(".objects.Material.Slider"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local Material = require(Path..".third-party.material-love")

local OSlider = Class("object.slider",OBase)

function OSlider:initialize(x,y,length,orientation,min,max,onChange)
  OBase.initialize(self)
  local PMug = require(Path)

  self.length, self.orientation, self.min, self.max = length or 0, orientation or "h", min or 0, max or 0
  self.onChange = onChange or function(obj,newValue) end

  --Shapes--
  self.SCircle = PMug.Shape.circle(0,0,8):setDrawingArgs(true,true,{0,0,0,0},{Material.colors.main("light-blue")},{Material.colors("light-blue","600")})
  self.SLine = PMug.Shape.line(0,0,self.orientation == "h" and self.length or 0,self.orientation == "v" and self.length or 0,3)
  self.SFLine = PMug.Shape.line(0,0,0,0,3):setDrawingArgs({Material.colors.main("light-blue")})

  --Actions--
  self.slideAction = PMug.Action.slideShape(0,0,self.length,self.orientation,self.SCircle,function(shape,obj,newX,newY)
    self.SFLine:setProperties(false,false,newX,newY)
    if self.orientation == "h" then
      local value = newX/self.length
      self.onChange(self,value*(max-min))
    elseif self.orientation == "v" then
      local value = newY/self.length
      self.onChange(self,value*(max-min))
    end
  end)
  self.updateStateAction = PMug.Action.updateState()

  --Drawers--
  self.Drawer = PMug.Drawer.material()

  --Handlers--
  self.Handler = PMug.Handler()

  --Registering--
  self:addHandler(self.Handler):addDrawer(self.Drawer)

  self.Handler:linkShape(self.SCircle):addAction(self.slideAction):addAction(self.updateStateAction)
  self.Drawer:linkShape(self.SLine):linkShape(self.SFLine):linkShape(self.SCircle)

  self:registerShape(self.SCircle)

  self:setPosition(x,y)
end

function OSlider:setOnChange(newFunc)
  self.onChange = newFunc or function(obj,newValue) end
end

function OSlider:getType()
  return "Slider"
end

return OSlider
