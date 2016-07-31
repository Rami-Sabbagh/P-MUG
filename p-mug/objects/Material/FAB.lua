local Path = string.sub(..., 1, -string.len(".objects.Material.FAB"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")

local Material = require(Path..".third-party.material-love")

local OFAB = Class("object.fab",OBase)

  OBase.initialize(self)
  local PMug = require(Path)

  --Actions--
  self.onClick = PMug.Action.onClick(oc)
  self.updateState = PMug.Action.updateState()

  --Shapes--

  --Drawers--
  self.Drawer = PMug.Drawer.material()

  --Handlers--
  self.Handler = PMug.Handler()

  --Registering--
  self:addDrawer(self.Drawer):addHandler(self.Handler)



  self:setPosition(x,y)
end

function OFAB:getType()
end

function OFAB:setOnClick(oc)
  self.onClick:setOnClick(oc)
end

return OFAB
