local Path = string.sub(..., 1, -string.len(".objects.Material.FAB"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local Material = require(Path..".third-party.material-love")

local OFAB = Class("object.fab",OBase)

function OFAB:initialize(x,y,iconName,colorName,r,oc)
  OBase.initialize(self)
  local PMug = require(Path)

  --Actions--
  self.onClick = PMug.Action.onClick(oc)
  self.updateState = PMug.Action.updateState()

  --Shapes--
  self.SBody = PMug.Shape.circle(0,0,r or 28):setDrawingArgs(false,false,{Material.colors(colorName or "red","600")},{Material.colors.main(colorName or "red")},{Material.colors(colorName or "red","400")})
  self.SIcon = PMug.Shape.icon(iconName or "blinds",0,0,0,"white",true)

  --Drawers--
  self.Drawer = PMug.Drawer.material()

  --Handlers--
  self.Handler = PMug.Handler()

  --Registering--
  self:addDrawer(self.Drawer):addHandler(self.Handler)
  self:registerShape(self.SBody):registerShape(self.SIcon)

  self.Drawer:linkShape(self.SBody):linkShape(self.SIcon)

  self.Handler:linkShape(self.SBody):linkShape(self.SIcon):addAction(self.updateState):addAction(self.onClick)

  self:setPosition(x,y)
end

function OFAB:getType()
  return "FAB"
end

function OFAB:setOnClick(oc)
  self.onClick:setOnClick(oc)
end

return OFAB
