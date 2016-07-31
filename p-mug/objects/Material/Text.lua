local Path = string.sub(..., 1, -string.len(".objects.Material.Text"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local Material = require(Path..".third-party.material-love")

local OText = Class("object.text",OBase)

function OText:initialize(t,x,y,w,h)
  OBase.initialize(self)
  local PMug = require(Path)

  --Shapes--
  self.SText = PMug.Shape.textrect(t,0,0,w,h,"center"):setDrawingArgs("display4",{Material.colors.main("blue")})

  --Drawer--
  self.Drawer = PMug.Drawer.material():linkShape(self.SText)

  --Registering--
  self:registerShape(self.SText)
  self:addDrawer(self.Drawer)

  self:setPosition(x,y)
end

function OText:getType()
  return "Text"
end

function OText:setText(t)
  self.SText:setProperties(t)
end

return OText
