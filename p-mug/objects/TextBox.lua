local Path = string.sub(..., 1, -string.len(".objects.TextBox"))
local Class = require(Path..".third-party.middleclass")
local OBase = require(Path..".api.objectbase")
local HBase = require(Path..".api.handlerbase")
local Material = require(Path..".third-party.material-love")

local OTextBox = Class("object.textbox",OBase)

function OTextBox:initialize(x,y,w,h,design,ht,t,otc)
  OBase.initialize(self)
  local PMug = require(Path)
  
  --Custom Callbacks--
  self.otc = otc or function(newtext,obj) end
  
  --Actions--
  self.OnSelection = PMug.Action.onSelection(function(obj)
    if require(Path).isMobile then
      love.keyboard.setTextInput(true)
    end
    return true
  end
  ,function(obj) return true end)
  self.OnTextInput = PMug.Action.onTextInput(function(text, newtext)
    self.SText:setProperties(text)
    if text == "" then
      self.SHText:setVisible(true)
    else
      self.SHText:setVisible(false)
    end
    self.otc(text,self)
  end)
  
  PMug.buildObject(self,design,x,y,w,h,ht,t,otc)
  
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