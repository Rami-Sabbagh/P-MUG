local Path = string.sub(..., 1, -string.len(".shapes.line"))
local Class = require(Path .. ".third-party.middleclass")

local SBase = Class("shape.Base") SBase.static.LGUIS = true --LGUIE: LoveGlass User Interface Shape

function SBase:initialize()
  self.hover, self.down = false, false --Used for themes to change color.
  self.drawingArgs = {} --The drawing args for themes
end

function SBase:setDrawingArgs(args)
  self.drawingArgs = args or {}
  self.hovered = false
  self.down = false
  return self
end

function SBase:isDown(isDown,dx,dy)
  if type(isDown) == "boolean" then
    self.down, self.dx, self.dy = isDown, dx, dy
  end
  return self.down, self.dx, self.dy
end

function SBase:isHovered(isHovered,hx,hy)
  if type(isHovered) == "boolean" then
    self.hovered, self.hx, self.hy = isHovered, hx, hy
  end
  return self.hovered, self.hx, self.hy
end

function SBase:getDrawingArgs()
  return self.drawingArgs
end

--Return a rect containing the shape, Used for objects to draw some text,images in center for ex.
function SBase:getContainingRect()
  return 0,0,0,0 --x,y,width,height
end

--Should have the same arguments as the initialize, Used to change the properties of the UI as width, height, x, y, etc....
function SBase:setProperties()
  
end

--You have to return the arguments you got in initialize, Used for themes to draw shapes.
function SBase:getProperties()
  
end

--Don't override this !
function SBase:draw()
  return
end

--Debug draw of the ui element, args: color( a table containing the color to draw {red,green,blue,alpha} ).
function SBase:drawDebug(color)
  
end

--Is that point in this ui element ?, args: x(The x position of the point) y(The y position of the point) pressure(For devices with touch and drawing screen/ mouse gives 1).
function SBase:isInUI(x,y,pressure)
  return false
end

return SBase