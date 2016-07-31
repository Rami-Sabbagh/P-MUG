local Path = string.sub(..., 1, -string.len(".objects.Material.Button"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local Material = require(Path..".third-party.material-love")

local OButton = Class("object.button",OBase)

function OButton:initialize(x,y,w,h,t,oc)
  OBase.initialize(self)
  local PMug = require(Path)

  --Actions--
  self.onClick = PMug.Action.onClick(oc)
  self.updateState = PMug.Action.updateState()

  --Shapes--
  self.SBody = PMug.Shape.rectangle(0,0,w,h):setDrawingArgs(false,false,{Material.colors("grey","200")})
  self.SText = PMug.Shape.textrect(t,0,0,w,h,"center"):setDrawingArgs("button",{Material.colors.main("blue")})

  --Drawers--
  self.Drawer = PMug.Drawer.material()

  --Handlers--
  self.Handler = PMug.Handler()

  --Registering--
  self:addDrawer(self.Drawer):addHandler(self.Handler)
  self:registerShape(self.SBody):registerShape(self.SText)

  self.Drawer:linkShape(self.SBody):linkShape(self.SText)

  self.Handler:linkShape(self.SBody):linkShape(self.SText):addAction(self.updateState):addAction(self.onClick)

  self:setPosition(x,y)
end

function OButton:getType()
  return "Button"
end

function OButton:setOnClick(oc)
  self.onClick:setOnClick(oc)
end

return OButton
