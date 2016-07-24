local Path = string.sub(..., 1, -string.len(".designs.Material"))
local Class = require(Path..".third-party.middleclass")
local Material = require(Path..".third-party.material-love")
local DSBase = require(Path..".api.designbase")

local MTDS = Class("design.material",DSBase)

local Config = {}
Config.TextBoxPadding = 5

Config.FrameBarHeight = 30

function MTDS:getName()
  return "Material"
end

function MTDS:buildButton(obj,x,y,w,h,t)
  local PMug = require(Path)
  
  obj.SBody = PMug.Shape.rectangle(0,0,w,h):setDrawingArgs(false,false,{Material.colors("grey","200")})
  obj.SText = PMug.Shape.textrect(t,0,0,w,h,"center"):setDrawingArgs("button",{Material.colors.main("blue")})
  obj.Drawer = PMug.Drawer.material()
  obj.Handler = PMug.Handler()
  obj.updateState = PMug.Action.updateState()
  obj:addDrawer(obj.Drawer):addHandler(obj.Handler)
  obj:registerShape(obj.SBody):registerShape(obj.SBody)
  obj.Drawer:linkShape(obj.SBody):linkShape(obj.SText)
  obj.Handler:linkShape(obj.SBody):linkShape(obj.SText):addAction(obj.updateState):addAction(obj.onClick)
end

function MTDS:buildText(obj,t,x,y,w,h)
  local PMug = require(Path)
  obj.SText = PMug.Shape.textrect(t,0,0,w,h,"center"):setDrawingArgs("display4",{Material.colors.main("blue")})
  obj.Drawer = PMug.Drawer.material():linkShape(obj.SText)
  obj:addDrawer(obj.Drawer)
end

function MTDS:buildTextBox(obj,x,y,w,h,ht,t,otc)
  local PMug = require(Path)
  
  --Actions--
  obj.UpdateStateAction = PMug.Action.updateState()
  
  --Shapes--
  obj.SBody = PMug.Shape.rectangle(0,0,w,h):setDrawingArgs(true,true,{Material.colors("grey","200")})
  obj.SHText = PMug.Shape.textrect(ht or "",Config.TextBoxPadding,Config.TextBoxPadding,w-Config.TextBoxPadding*2,h-Config.TextBoxPadding*2,"left"):setDrawingArgs("caption",{Material.colors.mono("black","hint-text")})
  obj.SText = PMug.Shape.textrect(t or "",Config.TextBoxPadding,Config.TextBoxPadding,w-Config.TextBoxPadding*2,h-Config.TextBoxPadding*2,"left"):setDrawingArgs("caption",{Material.colors.mono("black","text")})
  
  --Drawers--
  obj.Drawer = PMug.Drawer.material():linkShape(obj.SBody):linkShape(obj.SHText):linkShape(obj.SText)
  
  --Handlers--
  obj.HBody = PMug.Handler():linkShape(obj.SBody):addAction(obj.UpdateStateAction):addAction(obj.OnSelection):addAction(obj.OnTextInput)
  
  --Registering--
  obj:addHandler(obj.HBody)
  obj:addDrawer(obj.Drawer)
end

function MTDS:buildFrame(obj,x,y,w,h,t)
  local PMug = require(Path)
  
  --Actions--
  obj.UpdateStateAction = PMug.Action.updateState()
  
  --Shapes--
  obj.SBody = PMug.Shape.rectangle(0,0,w,h)
  obj.SBar = PMug.Shape.rectangle(0,0,w,Config.FrameBarHeight):setDrawingArgs(true,true,false,{Material.colors.main("teal")},false)
  obj.SIcon = PMug.Shape.icon("blinds",Config.FrameBarHeight/2,Config.FrameBarHeight/2,0,"black",false)
  obj.SText = PMug.Shape.textrect(t,Config.FrameBarHeight,0,w-Config.FrameBarHeight*2,Config.FrameBarHeight,"left"):setDrawingArgs("button",{Material.colors("teal","900")})
  obj.SCloseBox = PMug.Shape.rectangle(w-Config.FrameBarHeight,0,Config.FrameBarHeight,Config.FrameBarHeight):setDrawingArgs(true,true,{Material.colors("teal","300")},{Material.colors.main("teal")},{Material.colors("teal","400")})
  obj.SCloseIcon = PMug.Shape.icon("close",w-Config.FrameBarHeight/2,Config.FrameBarHeight/2,0,"black",false)
  
  --Contianer--
  obj.FrameContainer, obj.FrameContainerDrawer = obj:newContainer(0,Config.FrameBarHeight)
  
  --Drawers--
  obj.DMaterial = PMug.Drawer.material():linkShape(obj.SBody):linkShape(obj.SBar):linkShape(obj.SIcon):linkShape(obj.SText):linkShape(obj.SCloseBox):linkShape(obj.SCloseIcon)
  
  --Handlers--
  obj.HClose = PMug.Handler():linkShape(obj.SCloseBox):linkShape(obj.SCloseIcon):addAction(obj.UpdateStateAction):addAction(obj.CloseAction)
  obj.HBar = PMug.Handler():linkShape(obj.SBar):addAction(obj.DragAction):addAction(obj.SetToTopAction)
  obj.HBody = PMug.Handler():linkShape(obj.SBody):addAction(obj.SetToTopAction)
  
  --Registering--
  obj:addDrawer(obj.DMaterial):addDrawer(obj.FrameContainerDrawer):addHandler(obj.HClose):addHandler(obj.FrameContainer):addHandler(obj.HBar):addHandler(obj.HBody)
end

return MTDS