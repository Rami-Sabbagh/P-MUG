local Path = string.sub(..., 1, -string.len(".actions.onTextInput"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")
local utf8 = require("utf8")

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
  if flag or not obj:isSelected() then return end
  if key == "backspace" then
    local byteoffset = utf8.offset(self.text, -1)
    if byteoffset then self.text = string.sub(self.text, 1, byteoffset - 1) end
    self.otc(self.text,"")
    return true
  end
end

function AOTI:textinput(text,flag,obj)
  if flag or not obj:isSelected() then return end
  self.text = self.text..text
  self.otc(self.text,text)
  return true
end

return AOTI