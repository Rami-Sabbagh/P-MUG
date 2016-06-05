local Path = string.sub(..., 1, string.len(...) - string.len(".api.shapebase"))
local Class = require(Path..".third-party.middleclass")

local SBase = Class("shape.base") SBase.PMUGS = true --P-Mug Shape Class

function SBase:initialize()
  self.drawingArgs = {} --The drawing arguments for drawer to use.
end

function SBase:getDrawingArgs()
  return self.drawingArgs
end

--Return the shape type.
function SBase:getType()
  return "base"
end

--Return the drawtype of the shape. Refer to the drawer you are using.
function SBase:getDType()
  return "none"
end

--Can be used for making affects.
function SBase:update(dt)
  
end

--Returns the points of the bounding box for the transformed shape.
function SBase:computeAABB()
  return 0,0,0,0
end

--Checks whether a point lies inside the shape.
function SBase:testShape(x,y)
  return false
end

return SBase