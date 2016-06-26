local Path = string.sub(..., 1, -string.len(".objects.text"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")
local Material = require(Path..".third-party.material-love")

local OText = Class("object.text",OBase)

function OText:initialize(t,x,y,w,h)
  OBase.initialize(self)
  local PMug = require(Path)
  self.SText = PMug.Shape.textrect(t,0,0,w,h,"center"):setDrawingArgs("display4",{Material.colors.main("blue")})
  self.Drawer = PMug.Drawer.material():linkShape(self.SText)
  self:addDrawer(self.Drawer)
  
  self:setPosition(x,y)
end

function OText:setText(t)
  self.SText:setProperties(t)
end

return OText