local Path = string.sub(..., 1, -string.len(".objects.Material.TextBox"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")
local HBase = require(Path..".api.handlerbase")
local Material = require(Path..".third-party.material-love")

local OTextBox = Class("object.textbox",OBase)

local Config = {}
Config.TextPadding = 5

function OTextBox:initialize(x,y,w,h,ht,t,otc)
  OBase.initialize(self)
  local PMug = require(Path)

  --Custom Callbacks--
  self.otc = otc or function(newtext,self) end

  --Actions--
  self.OnSelection = PMug.Action.onSelection(function(self)
    if require(Path).isMobile then
      love.keyboard.setTextInput(true)
    end
    return true
  end
  ,function(self) return true end)
  self.OnTextInput = PMug.Action.onTextInput(function(text, newtext)
    self.SText:setProperties(text)
    if text == "" then
      self.SHText:setVisible(true)
    else
      self.SHText:setVisible(false)
    end
    self.otc(text,self)
  end)

  --Actions--
  self.UpdateStateAction = PMug.Action.updateState()

  --Shapes--
  self.SBody = PMug.Shape.rectangle(0,0,w,h):setDrawingArgs(true,true,{Material.colors("grey","200")})
  self.SHText = PMug.Shape.textrect(ht or "",Config.TextPadding,Config.TextPadding,w-Config.TextPadding*2,h-Config.TextPadding*2,"left"):setDrawingArgs("caption",{Material.colors.mono("black","hint-text")})
  self.SText = PMug.Shape.textrect(t or "",Config.TextPadding,Config.TextPadding,w-Config.TextPadding*2,h-Config.TextPadding*2,"left"):setDrawingArgs("caption",{Material.colors.mono("black","text")})

  --Drawers--
  self.Drawer = PMug.Drawer.material():linkShape(self.SBody):linkShape(self.SHText):linkShape(self.SText)

  --Handlers--
  self.HBody = PMug.Handler():linkShape(self.SBody):addAction(self.UpdateStateAction):addAction(self.OnSelection):addAction(self.OnTextInput)

  --Registering--
  self:registerShape(self.SBody):registerShape(self.SHText):registerShape(self.SText)
  self:addHandler(self.HBody)
  self:addDrawer(self.Drawer)

  self:setPosition(x,y)
end

function OTextBox:getType()
  return "TextBox"
end

function OTextBox:setOnTextChanged(func)
  self.otc = func or function() end
end

function OTextBox:getText()
  local Text = self.SText:getProperties()
  return Text
end

return OTextBox
