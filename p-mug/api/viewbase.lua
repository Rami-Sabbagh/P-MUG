local Path = string.sub(..., 1, string.len(...) - string.len(".api.viewbase"))
local Class = require(Path..".third-party.middleclass")

local VBase = Class("view.base") VBase.PMUGV = true --P-Mug View Class

function VBase:initialize(name)
  self.VName = name --The view name.
  self.ZLayer = {} --The z dimension of objects.
end

function VBase:getName()
  return self.VName
end

function VBase:registerObject(obj,z)
  if not self.ZLayer[z or 0] then self.ZLayer[z or 0] = {} end
  table.insert(self.ZLayer[z or 0],obj)
  return self,#self.ZLayer[z or 0]
end

function VBase:enter(prevView,...)

end

function VBase:leave(nextView,...)

end

function VBase:draw()
  for i=0,#self.ZLayer do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.draw then obj:draw() end
      end
    end
  end
end

function VBase:update(dt)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.update then obj:update(dt) end
      end
    end
  end
end

function VBase:keypressed(key,scancode,isrepeat)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.keypressed then obj:keypresssd(key,scancode,isrepeat) end
      end
    end
  end
end

function VBase:keyreleased(key,scancode)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.keyreleased then obj:keyreleased(key,scancode) end
      end
    end
  end
end

function VBase:textinput(text)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.textinput then obj:textinput(text) end
      end
    end
  end
end

function VBase:mousepressed(x,y,button,istouch)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.mousepressed then obj:mousepressed(x,y,button,istouch) end
      end
    end
  end
end

function VBase:mousemoved(x,y,dx,dy)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.mousemoved then obj:mousemoved(x,y,dx,dy) end
      end
    end
  end
end

function VBase:mousereleased(x,y,button,istouch)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.mousereleased then obj:mousereleased(x,y,button,istouch) end
      end
    end
  end
end

function VBase:touchpressed(id,x,y,dx,dy,pressure)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.touchpressed then obj:touchpressed(id,x,y,dx,dy,pressure) end
      end
    end
  end
end

function VBase:touchmoved(id,x,y,dx,dy,pressure)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.touchmoved then obj:touchmoved(id,x,y,dx,dy,pressure) end
      end
    end
  end
end

function VBase:touchreleased(id,x,y,dx,dy,pressure)
  for i=#self.ZLayer,1,-1 do
    local l = self.ZLayer[i]
    if l then
      for n=1,#l do
        local obj = l[n]
        if obj and obj.touchreleased then obj:touchreleased(id,x,y,dx,dy,pressure) end
      end
    end
  end
end

return VBase