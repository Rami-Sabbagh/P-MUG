local Path = string.sub(..., 1, -string.len(".actions.onTextInput"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")

local AOTI = Class("action.onTextInput",ABase)

function AOTI:initialize(ontextchanged)
  ABase.initialize(self)
  self.text = ""
  self.otc = ontextchanged or function() end
end

function AOTI:setOnTextChanged(func)
  self.otc = func or function() end
end

function AOTI:keypressed(key,scancode,isrepeat,flag,obj)
  if flag then return end
  if key == "backspace" then
    self.text = self.text:sub(0,-2)
    self.otc(self.text,"")
    return true
  end
end

function AOTI:keyreleased(key,scancode,flag,obj)
  
end

function AOTI:textinput(text,flag,obj)
  if flag or not obj:isSelected() then return end
  self.text = self.text..text
  self.otc(self.text,text)
  return true
end

return AOTI