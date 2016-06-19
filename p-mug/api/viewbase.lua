local Path = string.sub(..., 1, -string.len(".api.viewbase"))
local Class = require(Path..".third-party.middleclass")

local VBase = Class("view.base") VBase.PMUGV = true --P-Mug View Class

function VBase:initialize(name)
  self.VName = name --The view name.
  self.ZLayer = {} --The z dimension of objects.
  self.ZObjects = {}
  self:resetLayers()
end

function VBase:resetLayers()
  for i=0,5 do
    self.ZLayer[i] = {}
  end
end

function VBase:getName()
  return self.VName
end

function VBase:registerObject(obj,z)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  table.insert(self.ZLayer[z or 0],obj)
  self.ZObjects[obj] = #self.ZLayer[z or 0]
  obj:setView(self,z or 0)
  return self,#self.ZLayer[z or 0]
end

function VBase:setZ(obj,z)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  local v, oz = obj:getView()
  if not v then return error("This object is not registered in any view !") end
  if v ~= self then return error("This object is not registered in this view !") end
  self.ZLayer[oz][self.ZObjects[obj]] = false
  table.insert(self.ZLayer[z or 0],obj)
  self.ZObjects[obj] = #self.ZLayer[z or 0]
  obj:setView(self,z)
end

function VBase:setToTop(obj)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  local v, oz = obj:getView()
  if not v then return error("This object is not registered in any view !") end
  if v ~= self then return error("This object is not registered in this view !") end
  local newOrder = {}
  for id, object in ipairs(self.ZLayer[oz]) do
    if object ~= obj then
      table.insert(newOrder,object)
      self.ZObjects[object] = #newOrder
    end
  end
  table.insert(newOrder,obj)
  self.ZObjects[obj] = #newOrder
  self.ZLayer[oz] = newOrder
end

function VBase:removeObject(obj,z)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  local v, oz = obj:getView()
  if not v then return error("This object is not registered in any view !") end
  if v ~= self then return error("This object is not registered in this view !") end
  self.ZLayer[oz][self.ZObjects[obj]] = false
  self.ZObjects[obj] = nil
  obj:setView(nil)
end

function VBase:enter(prevView,...)

end

function VBase:leave(nextView,...)

end

function VBase:draw()
  for i=0,5 do
    local l = self.ZLayer[i]
    if l then
      for id, obj in ipairs(l) do
        if obj and obj.draw then obj:draw() end
      end
    end
  end
end

function VBase:update(dt)
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.update then obj:update(dt) end
      end
    end
  end
end

function VBase:keypressed(key,scancode,isrepeat)
  for i=#5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.keypressed then obj:keypressed(key,scancode,isrepeat) end
      end
    end
  end
end

function VBase:keyreleased(key,scancode)
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.keyreleased then obj:keyreleased(key,scancode) end
      end
    end
  end
end

function VBase:textinput(text)
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.textinput then obj:textinput(text) end
      end
    end
  end
end

function VBase:mousepressed(x,y,button,istouch)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.mousepressed then flag = obj:mousepressed(x,y,button,istouch,flag) or flag end
      end
    end
  end
end

function VBase:mousemoved(x,y,dx,dy)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.mousemoved then flag= obj:mousemoved(x,y,dx,dy,flag) or flag end
      end
    end
  end
end

function VBase:mousereleased(x,y,button,istouch)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.mousereleased then flag = obj:mousereleased(x,y,button,istouch,flag) or flag end
      end
    end
  end
end

function VBase:touchpressed(id,x,y,dx,dy,pressure)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.touchpressed then flag = obj:touchpressed(id,x,y,dx,dy,pressure,flag) or flag end
      end
    end
  end
end

function VBase:touchmoved(id,x,y,dx,dy,pressure)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.touchmoved then flag = obj:touchmoved(id,x,y,dx,dy,pressure,flag) or flag end
      end
    end
  end
end

function VBase:touchreleased(id,x,y,dx,dy,pressure)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.touchreleased then flag = obj:touchreleased(id,x,y,dx,dy,pressure,flag) or flag end
      end
    end
  end
end

return VBase