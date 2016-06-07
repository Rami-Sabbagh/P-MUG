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

function HBase:update(dt)
  for k, Act in ipairs(self.Actions) do
    if Act and Act.update then Act:update(dt) end
  end
end

function HBase:mousepressed(x,y,button,istouch)
  if istouch then return end
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      --[[for k,shp in ipairs(self.LShapes) do
        shp:isDown(true,x,y)
      end]]
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerDown then Act:handlerDown(x,y,button) Act.hd.mp = true end
      end
      break
    end
  end
end

function HBase:mousemove(x,y,dx,dy)
  
end

function HBase:mousereleased(x,y,button,istouch)
  if istouch then return end
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k, Act in ipairs(self.Actions) do
        if Act and Act.handlerReleased and Act.hd.mp then Act:handlerReleased(x,y,button) Act.hd.mp = false end
      end
      return
    end
  end
  for k, Act in ipairs(self.Actions) do
    if Act and Act.handlerReleased and Act.hd.mp then Act:handlerCancelled(x,y,button) Act.hd.mp = false end
  end
  --[[for k,shape in ipairs(self.LShapes) do
    shape:isDown(false,x,y)
  end]]
end



return HBase