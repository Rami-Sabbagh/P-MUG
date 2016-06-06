local Path = string.sub(..., 1, -string.len(".objects.button"))
local Class = require(Path .. ".third-party.middleclass")
local OBase = require(Path .. ".objects.base")

local OButton = Class("object.button",OBase)

function OButton:initialize(...)
  OBase.initialize(self,...) self.text = ""
end

function OButton:setText(text)
  self.text = text or ""
  return self
end

function OButton:getText()
  return self.text
end

function OButton:drawText()
  local x,y,w,h = self:getElementRect("Body")
  self:printText(self.text,x,y+h/2,0,w)
end

function OButton:UIPressed(ui,x,y,pressure)
  if not ui.name == "Body" then return end
  self.hover, self.down = true, true
end

function OButton:UIMoved(ui,x,y,ox,oy,inside,pressure)
  if not ui.name == "Body" then return end
  self.hover, self.down = inside, inside
end

function OButton:UIReleased(ui,x,y,ox,oy,inside,pressure)
  if not ui.name == "Body" then return end
  self.hover, self.down = inside, false
  if inside then self:fireEvent("Clicked") end
end

function OButton:UIHovered(ui,x,y,pressure)
  if not ui.name == "Body" then return end
  self.hover = true
end

function OButton:UIUnHovered(ui,x,y,pressure)
  if not ui.name == "Body" then return end
  self.hover = false
end

return OButton