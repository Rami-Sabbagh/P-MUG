local Path = string.sub(..., 1, string.len(...) - string.len(".objects.base"))
local ThemeManager = require(Path..".libraries.ThemeManager")
local GlassUtil = require(Path .. ".libraries.GlassUtil")
local Class = require(Path .. ".third-party.middleclass")
local UIElement = require(Path..".libraries.UIElement")

local OBase = Class("object.Base") OBase.static.LGOE = true --LGOE: LoveGlass Object Element

function OBase:initialize(viewname,objname)
  self.UIElements = {}
  self.view = viewname
  self.name = objname
  self.fontData = {}
end

function OBase:getView()
  return self.view
end

function OBase:getName()
  return self.name
end

function OBase:getFontData()
  return self.fontData
end

function OBase:setFontData(data)
  self.fontData = data
  return self
end

function OBase:getElementRect(name)
  for k, uie in ipairs(self.UIElements) do
    if uie and uie.Name == name then return uie:getRect() end
  end
  return 0,0,0,0
end

function OBase:draw()
  for z=#self.UIElements, 1, -1 do
    local Element = self.UIElements[z]
    Element:draw(self)
  end
  self:drawText()
end

--Draw object text here.
function OBase:drawText()
  
end

function OBase:printText(Text,X,Y,R,Limit)
  ThemeManager:printText(self,Text,X,Y,R,Limit,unpack(self:getFontData()))
end

function OBase:update(dt)
  
end

function OBase:pointerPressed(id,x,y,pressure)
  for k = #self.UIElements, 1, -1 do
    local UI = self.UIElements[k]
    if UI:isInUI(x,y,pressure) then
      if not UI.touchID then
        UI.touchID, UI.touchX, UI.touchY = id, x, y
        self:UIPressed(UI,x,y,pressure)
        return true
      end
      break
    end
  end
end

function OBase:pointerMoved(id,x,y,pressure)
  for k = #self.UIElements, 1, -1 do
    local UI = self.UIElements[k]
    if UI.touchID then
      if UI.touchID == id then
        self:UIMoved(UI,x,y,UI.touchX,UI.touchY,UI:isInUI(x,y,pressure),pressure)
        return true
      end
    elseif UI:isInUI(x,y,pressure) then
      if self.HoveredUI then
        if self.HoveredUI == UI then
          return
        else
          self:UIUnHovered(self.HoveredUI)
        end
      end
      self:UIHovered(UI,x,y,pressure) self.HoveredUI = UI
      return
    end
  end
  if self.HoveredUI then self:UIUnHovered(self.HoveredUI) self.HoveredUI = nil end
end

function OBase:pointerReleased(id,x,y,pressure)
  for k = #self.UIElements, 1, -1 do
    local UI = self.UIElements[k]
    if UI.touchID then
      if UI.touchID == id then
        self:UIReleased(UI,x,y,UI.touchX,UI.touchY,UI:isInUI(x,y,pressure),pressure)
        UI.touchID = nil
        return true
      end
    elseif UI:isInUI(x,y,pressure) then
      if self.HoveredUI then
        if self.HoveredUI == UI then
          return
        else
          self:UIUnHovered(self.HoveredUI)
        end
      end
      self:UIHovered(UI,x,y,pressure) self.HoveredUI = UI
      return
    end
  end
  if self.HoveredUI then self:UIUnHovered(self.HoveredUI) self.HoveredUI = nil end
end

function OBase:UIPressed(ui,x,y,pressure)
  
end

function OBase:UIMoved(ui,x,y,ox,oy,inside,pressure)
  
end

function OBase:UIReleased(ui,x,y,ox,oy,inside,pressure)
  
end

function OBase:UIHovered(ui,x,y,pressure)
  
end

function OBase:UIUnHovered(ui)
  
end

function OBase:fireEvent(eventname,...)
  GlassUtil:fireEvent(self.view,self.name,eventname,...)
end

function OBase:newUIElement(Name,...)
  local Shapes = {...} local Element = UIElement(Name)
  for k, shape in ipairs(Shapes) do Element:insertUIShape(shape) end
  table.insert(self.UIElements,Element)
  return Element
end

return OBase