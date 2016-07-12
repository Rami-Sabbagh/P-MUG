local Path = string.sub(..., 1, -string.len(".api.containerbase"))
local Class = require(Path..".third-party.middleclass")

local DBase = require(Path..".api.drawerbase")

local CDBase = Class("drawer.container", DBase) CDBase.PMUGD = true --[[P-Mug Drawer Class]] 
function CDBase:initialize(container)
  self.container = container
end

function CDBase:draw()
  love.graphics.push()
  love.graphics.translate(self.container:getOffset())
  self.container:draw()
  love.graphics.pop()
end

local CBase = Class("container.base") CBase.PMUGC = true --P-Mug Container Class
CBase.PMUGH = true --[[P-Mug Handler Class]] 

function CBase:initialize(parent,ox, oy)
  self.ZLayer = {} --The z dimension of objects.
  self.ZObjects = {}
  self:resetLayers()
  
  self.pobj = parent
  self.drawer = CDBase(self)
  
  self.ox, self.oy = ox or 0, oy or 0
  self.filtershapes = {}
end

function CBase:setOffset(x,y)
  self.ox, self.oy = x or self.ox, y or self.oy
end

function CBase:getOffset()
  return self.ox, self.oy
end

function CBase:getDrawer()
  return self.drawer
end

function CBase:resetLayers()
  for i=0,5 do
    self.ZLayer[i] = {}
  end
end

function CBase:addFilterShape(shape)
  if not shape.PMUGS then return error("This isn't a P-Mug shape class") end
  table.insert(self.filtershapes,shape)
  return self, #self.filtershapes
end

function CBase:registerObject(obj,z)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  table.insert(self.ZLayer[z or 0],obj)
  self.ZObjects[obj] = #self.ZLayer[z or 0]
  obj:setParentContainer(self,z or 0,self.pobj)
  return self,#self.ZLayer[z or 0]
end

function CBase:setZ(obj,z)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  local v, oz = obj:getParentContainer()
  if not v then return error("This object is not registered in any container !") end
  if v ~= self then return error("This object is not registered in this container !") end
  self.ZLayer[oz][self.ZObjects[obj]] = false
  table.insert(self.ZLayer[z or 0],obj)
  self.ZObjects[obj] = #self.ZLayer[z or 0]
  obj:setParentContainer(self,z,self.pobj)
end

function CBase:setToTop(obj)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  local v, oz = obj:getParentContainer()
  if not v then return error("This object is not registered in any container !") end
  if v ~= self then return error("This object is not registered in this container !") end
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

function CBase:removeObject(obj,z)
  local z = z or 0 z = math.floor(z+0.5) if z > 5 then z = 5 end if z < 0 then z = 0 end
  if not obj.PMUGO then return error("This isn't a P-Mug object class") end
  local v, oz = obj:getParentContainer()
  if not v then return error("This object is not registered in any container !") end
  if v ~= self then return error("This object is not registered in this container !") end
  self.ZLayer[oz][self.ZObjects[obj]] = false
  self.ZObjects[obj] = nil
  obj:setView(nil)
end

function CBase:draw()
  for i=0,5 do
    local l = self.ZLayer[i]
    if l then
      for id, obj in ipairs(l) do
        if obj and obj.draw then obj:draw() end
      end
    end
  end
end

function CBase:update(dt)
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.update then obj:update(dt) end
      end
    end
  end
end

function CBase:keypressed(key,scancode,isrepeat,pflag)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.keypressed then flag = obj:keypressed(key,scancode,isrepeat,pflag or flag) or flag end
      end
    end
  end
  return flag
end

function CBase:keyreleased(key,scancode,pflag)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.keyreleased then flag = obj:keyreleased(key,scancode,pflag or flag) or flag end
      end
    end
  end
  return flag
end

function CBase:textinput(text,pflag)
  local flag
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.textinput then flag = obj:textinput(text,pflag or flag) or flag end
      end
    end
  end
  return flag
end

function CBase:mousepressed(x,y,button,istouch,parent,obstruct)
  local flag  x, y = x-self.ox, y-self.oy
  local filterFlag
  for k, shp in ipairs(self.filtershapes) do
    if not shp:testShape(x,y) then
      filterFlag = true
      break
    end
  end
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.mousepressed then flag = obj:mousepressed(x,y,button,istouch,obstruct or flag or filterFlag) or flag end
      end
    end
  end
  return flag
end

function CBase:mousemoved(x,y,dx,dy,istouch,parent,obstruct)
  local flag  x, y = x-self.ox, y-self.oy
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.mousemoved then flag = obj:mousemoved(x,y,dx,dy,istouch,obstruct or flag) or flag end
      end
    end
  end
  return flag
end

function CBase:mousereleased(x,y,button,istouch,parent,obstruct)
  local flag  x, y = x-self.ox, y-self.oy
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.mousereleased then flag = obj:mousereleased(x,y,button,istouch,obstruct or flag) or flag end
      end
    end
  end
  return flag
end

function CBase:touchpressed(id,x,y,dx,dy,pressure,parent,obstruct)
  local flag  x, y = x-self.ox, y-self.oy
  local filterFlag
  for k, shp in ipairs(self.filtershapes) do
    if not shp:testShape(x,y) then
      filterFlag = true
      break
    end
  end
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.touchpressed then flag = obj:touchpressed(id,x,y,dx,dy,pressure,obstruct or flag or filterFlag) or flag end
      end
    end
  end
  return flag
end

function CBase:touchmoved(id,x,y,dx,dy,pressure,parent,obstruct)
  local flag  x, y = x-self.ox, y-self.oy
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.touchmoved then flag = obj:touchmoved(id,x,y,dx,dy,pressure,obstruct or flag) or flag end
      end
    end
  end
  return flag
end

function CBase:touchreleased(id,x,y,dx,dy,pressure,parent,obstruct)
  local flag  x, y = x-self.ox, y-self.oy
  for i=5,0,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=#l,0,-1 do local obj = l[n]
        if obj and obj.touchreleased then flag = obj:touchreleased(id,x,y,dx,dy,pressure,obstruct or flag) or flag end
      end
    end
  end
  return flag
end

return CBase