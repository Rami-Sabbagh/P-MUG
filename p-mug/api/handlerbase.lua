local Path = string.sub(..., 1, -string.len(".api.handlerbase"))
local Class = require(Path..".third-party.middleclass")

local HBase = Class("handler.base") HBase.PMUGH = true --P-Mug Handler Class

function HBase:initialize()
  self.Actions = {}
  self.LShapes = {}
end

function HBase:addAction(act)
  if not act.PMUGA then return error("This isn't a P-Mug action class") end
  table.insert(self.Actions,act)
  return self, #self.Actions
end

function HBase:linkShape(shp)
  if not shp.PMUGS then return error("This isn't a P-Mug shape class") end
  table.insert(self.LShapes,shp)
  return self, #self.LShapes
end

function HBase:update(dt,obj)
  for k, Act in ipairs(self.Actions) do
    if Act and Act.update then Act:update(dt,obj,self.LShapes) end
  end
end

function HBase:selected(obj)
  local flag
  for k, Act in ipairs(self.Actions) do
    if Act and Act.selected then flag = Act:selected(obj) or flag end
  end
  return flag
end

function HBase:deselected(obj)
  local flag
  for k, Act in ipairs(self.Actions) do
    if Act and Act.deselected then flag = Act:deselected(obj) or flag end
  end
  return flag
end

function HBase:keypressed(key,scancode,isrepeat,pflag,obj)
  local flag
  for k, Act in ipairs(self.Actions) do
    if Act and Act.keypressed then flag = Act:keypressed(key,scancode,isrepeat,pflag,obj) or flag end
  end
  return flag
end

function HBase:keyreleased(key,scancode,pflag,obj)
  local flag
  for k, Act in ipairs(self.Actions) do
    if Act and Act.keyreleased then flag = Act:keyreleased(key,scancode,pflag,obj) or flag end
  end
  return flag
end

function HBase:textinput(text,pflag,obj)
  local flag
  for k, Act in ipairs(self.Actions) do
    if Act and Act.textinput then flag = Act:textinput(text,pflag,obj) or flag end
  end
  return flag
end

function HBase:mousepressed(x,y,button,istouch,obj,obstruct)
  if istouch then return end
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerDown then Act:handlerDown(x,y,button,obj,shape,self.LShapes,obstruct) Act.hd.mp = shape end
      end
      obj:select()
      return true
    end
  end
  obj:deselect()
end

function HBase:mousemoved(x,y,dx,dy,istouch,obj,obstruct)
  if istouch then return end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerDragged and Act.hd.mp then Act:handlerDragged(x,y,dx,dy,obj,Act.hd.mp,self.LShapes,obstruct) end
  end
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerHovering and not Act.hd.mp then Act:handlerHovering(x,y,dx,dy,obj,shape,self.LShapes,obstruct) Act.hd.h = {x=x,y=y} end
      end
      return true
    end
  end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerUnhovered and Act.hd.h and not Act.hd.mp then Act:handlerUnhovered(x,y,dx,dy,obj,self.LShapes,obstruct) Act.hd.h = false end
  end
end

function HBase:mousereleased(x,y,button,istouch,obj,obstruct)
  if istouch then return end
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerReleased and Act.hd.mp then Act:handlerReleased(x,y,button,obj,Act.hd.mp,self.LShapes,obstruct) Act.hd.mp = false end
      end
      return true
    end
  end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerCancelled and Act.hd.mp then Act:handlerCancelled(x,y,button,obj,Act.hd.mp,self.LShapes,obstruct) Act.hd.mp = false end
  end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerUnhovered and Act.hd.h and not Act.hd.mp then Act:handlerUnhovered(x,y,Act.hd.h.x-x,Act.hd.h.y-y,obj,self.LShapes,obstruct) Act.hd.h = false end
  end
end

function HBase:touchpressed(id,x,y,dx,dy,pressure,obj,obstruct)
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerDown and not Act.hd.tid and not Act.hd.mp then Act:handlerDown(x,y,pressure,obj,shape,self.LShapes,obstruct) Act.hd.tid = id Act.hd.shp = shape end
      end
      obj:select()
      return true
    end
  end
  obj:deselect()
end

function HBase:touchmoved(id,x,y,dx,dy,pressure,obj,obstruct)
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerDragged and not Act.hd.mp and Act.hd.tid and Act.hd.tid == id then Act:handlerDragged(x,y,dx,dy,obj,Act.hd.shp,self.LShapes,obstruct) end
  end
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerHovering and not Act.hd.mp and not Act.hd.tid then Act:handlerHovering(x,y,dx,dy,obj,shape,self.LShapes,obstruct) Act.hd.h = {x=x,y=y} end
      end
      return true
    end
  end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerUnhovered and Act.hd.h and not Act.hd.mp and not Act.hd.tid then Act:handlerUnhovered(x,y,dx,dy,obj,self.LShapes,obstruct) Act.hd.h = false end
  end
end

function HBase:touchreleased(id,x,y,dx,dy,pressure,obj,obstruct)
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerReleased and not Act.hd.mp and Act.hd.tid and Act.hd.tid == id then Act:handlerReleased(x,y,pressure,obj,Act.hd.mp,self.LShapes,obstruct) Act.hd.shp = nil Act.hd.tid = nil end
      end
      return true
    end
  end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerCancelled and not Act.hd.mp and Act.hd.tid and Act.hd.tid == id then Act:handlerCancelled(x,y,pressure,obj,Act.hd.mp,self.LShapes,obstruct) Act.hd.shp = nil Act.hd.tid = nil end
  end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerUnhovered and Act.hd.h and not Act.hd.mp and not Act.hd.tid then Act:handlerUnhovered(x,y,Act.hd.h.x-x,Act.hd.h.y-y,obj,self.LShapes,obstruct) Act.hd.h = false end
  end
end

return HBase