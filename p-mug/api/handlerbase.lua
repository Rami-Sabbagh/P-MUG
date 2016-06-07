local Path = string.sub(..., 1, -string.len(".api.handlerbase"))
local Class = require(Path..".third-party.middleclass")

local HBase = Class("handler.base") HBase.PMUGH = true --P-Mug Handler Class

function HBase:initialize()
  self.LShapes = {}
end

function HBase:linkShape(shp)
  if not shp.PMUGS then return error("This isn't a P-Mug shape class") end
  table.insert(self.LShapes,shp)
  return self, #self.LShapes
end

function HBase:update(dt)
  
end

function HBase:mousepressed(x,y,button)
  for k,shape in ipairs(self.LShapes) do
    if shape:testShape(x,y) then
      for k,shp in ipairs(self.LShapes) do
        shp:isDown(true,x,y)
      end
      break
    end
  end
end

function HBase:mousereleased(x,y,button)
  for k,shape in ipairs(self.LShapes) do
    shape:isDown(false,x,y)
  end
end

function HBase:mousemove(x,y,dx,dy)
  
end

return HBase