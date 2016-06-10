local Path = string.sub(..., 1, -string.len(".objects.frame"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")
local HBase = require(Path..".api.handlerbase")
local Material = require(Path..".third-party.material-love")

local OFrame = Class("object.frame",OBase)

local Config = {}
Config.BarHeight = 30
Config.BarTextYOffset = 3

function OFrame:initialize(x,y,w,h,t)
  OBase.initialize(self)
  local PMug = require(Path)
  self.SBody = PMug.Shape.rectangle(0,0,w,h)
  self.DragAction = PMug.Action.dragObject()
  self.SBar = PMug.Shape.rectangle(0,0,w,Config.BarHeight):setDrawingArgs(true,true,false,{Material.colors.main("teal")},false)
  self.SIcon = PMug.Shape.icon("blinds",Config.BarHeight/2,Config.BarHeight/2,0,"black",false)
  self.SText = PMug.Shape.textrect(t,Config.BarHeight,Config.BarTextYOffset,w-Config.BarHeight*2,Config.BarHeight,"left"):setDrawingArgs("title",{Material.colors("teal","900")})
  self.DMaterial = PMug.Drawer.material() self.HBar = HBase():linkShape(self.SBar):addAction(self.DragAction)
  self.DMaterial:linkShape(self.SBody):linkShape(self.SBar):linkShape(self.SIcon):linkShape(self.SText)
  self.HBody = HBase():linkShape(self.SBody)
  self:addDrawer(self.DMaterial):addHandler(self.HBar):addHandler(self.HBody)
  
  self:setPosition(x,y)
end

return OFrame