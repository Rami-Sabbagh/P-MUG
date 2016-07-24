local Path = string.sub(..., 1, -string.len(".api.objectbase"))
local Class = require(Path..".third-party.middleclass")

local CBase = require(Path..".api.containerbase")

local OBase = Class("object.base") OBase.PMUGO = true --P-Mug Object Class

function OBase:initialize()
  self.drawers = {}
  self.handlers = {}
  self.shapes = {}
  self.containers = {}
  self.pos = {x=0,y=0,z=0}
end

function OBase:newContainer(ox,oy)
  local Container = CBase(self,ox,oy)
  local ContainerDrawer = Container:getDrawer()
  self:registerContainer(Container)
  return Container, ContainerDrawer, #self.containers
end

function OBase:registerContainer(container)
  if not container.PMUGC then return error("This isn't a P-Mug container class") end
  table.insert(self.containers,container)
  return self, #self.containers
end

function OBase:setParentContainer(container,z,parentobj)
  self.parentcontainer = container
  self.pos.z = z or self.pos.z
  self.parentobj = parentobj or self.parentobj
  return self
end

function OBase:getType()
  return "Base" --The type of the object (button, frame, slider, etc..) Must start with a capital letter !
end

function OBase:getParent()
  return self.parentobj
end

function OBase:getParentContainer()
  return self.parentcontainer, self.pos.z, self.parentobj
end

function OBase:setPosition(x,y,z)
  self.pos = {x=x or self.pos.x, y=y or self.pos.y, z=z or self.pos.z}
  if self.parentcontainer and z then self.parentcontainer:setZ(self,z) end
  return self
end

function OBase:getPosition(x,y,z)
  return self.pos.x, self.pos.y, self.pos.z
end

function OBase:isSelected()
  return self.selected or false
end

function OBase:toggleSelection()
  if self:isSelected() then
    self:deselect()
  else
    self:select()
  end
end

function OBase:select()
  if not self:isSelected() then
    self.selected = true
    local flag
    for k, H in ipairs(self.handlers) do
      if H.selected then flag = H:selected(self) or flag end
    end
    if not flag then self.selected = nil end
    return flag
  end
end

function OBase:deselect()
  if self:isSelected() then
    self.selected = nil
    local flag
    for k, H in ipairs(self.handlers) do
      if H.deselected then flag = H:deselected(self) or flag end
    end
    if not flag then self.selected = true end
    return flag
  end
end

function OBase:setToTop()
  if not self.parentcontainer then return end
  self.parentcontainer:setToTop(self)
end

function OBase:addDrawer(drawer)
  if not drawer.PMUGD then return error("This isn't a P-Mug drawer class") end
  table.insert(self.drawers,drawer)
  return self, #self.drawers
end

function OBase:addHandler(handler)
  if not handler.PMUGH then return error("This isn't a P-Mug handler class") end
  table.insert(self.handlers,handler)
  return self, #self.handlers
end

function OBase:registerShape(shape)
  if not shape.PMUGS then return error("This isn't a P-Mug shape class") end
  table.insert(self.shapes,shape)
  return self, #self.shapes
end

function OBase:destroy()
  if self.view and z then self.view:removeObject(self,self.pos.z) end
  self.dead = true
end

function OBase:getBackToLife()
  self.dead = false
end

function OBase:draw()
  if self.dead then return end
  love.graphics.push()
  love.graphics.translate(self.pos.x,self.pos.y)
  for k, D in ipairs(self.drawers) do
    if D.draw then D:draw(self) end
  end
  love.graphics.pop()
end

function OBase:update(dt)
  if self.dead then return end
  for k, H in ipairs(self.handlers) do
    if H.update then H:update(dt,self) end
  end
  
  for k, S in ipairs(self.shapes) do
    if S.update then S:update(dt,self) end
  end
  
  for k, D in ipairs(self.drawers) do
    if D.update then D:update(dt,self) end
  end
end

function OBase:keypressed(key,scancode,isrepeat,pflag)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.keypressed then flag = H:keypressed(key,scancode,isrepeat,pflag or flag,self) or flag end
  end
  return flag or self:isSelected()
end

function OBase:keyreleased(key,scancode,pflag)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.keyreleased then flag = H:keyreleased(key,scancode,pflag or flag,self) or flag end
  end
  return flag or self:isSelected()
end

function OBase:textinput(text,pflag)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.textinput then flag = H:textinput(text,pflag or flag,self) or flag end
  end
  return flag or self:isSelected()
end

function OBase:mousepressed(x,y,button,istouch,obstruct)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.mousepressed then flag = H:mousepressed(x-self.pos.x,y-self.pos.y,button,istouch,self,obstruct or flag) or flag end
  end
  return flag or self:isSelected()
end

function OBase:mousemoved(x,y,dx,dy,istouch,obstruct)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.mousemoved then flag = H:mousemoved(x-self.pos.x,y-self.pos.y,dx,dy,istouch,self,obstruct or flag) or flag end
  end
  return flag or self:isSelected()
end

function OBase:mousereleased(x,y,button,istouch,obstruct)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.mousereleased then flag = H:mousereleased(x-self.pos.x,y-self.pos.y,button,istouch,self,obstruct or flag) or flag end
  end
  return flag or self:isSelected()
end

function OBase:touchpressed(id,x,y,dx,dy,pressure,obstruct)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.touchpressed then flag =  H:touchpressed(id,x-self.pos.x,y-self.pos.y,dx,dy,pressure,self,obstruct or flag) or flag end
  end
  return flag or self:isSelected()
end

function OBase:touchmoved(id,x,y,dx,dy,pressure,obstruct)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.touchmoved then flag = H:touchmoved(id,x-self.pos.x,y-self.pos.y,dx,dy,pressure,self,obstruct or flag) or flag end
  end
  return flag or self:isSelected()
end

function OBase:touchreleased(id,x,y,dx,dy,pressure,obstruct)
  if self.dead then return end
  local flag
  for k, H in ipairs(self.handlers) do
    if H.touchreleased then flag = H:touchreleased(id,x-self.pos.x,y-self.pos.y,dx,dy,pressure,self,obstruct or flag) or flag end
  end
  return flag or self:isSelected()
end

return OBase