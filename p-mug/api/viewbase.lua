local Path = ...
local Class = require(Path..".third-party.middleclass",Path)

local VBase = Class("view.base") VBase.static.PMUGV = true --P-Mug View Class

function VBase:initialize()
  self.ZLayer = {} --The z dimension of objects.
end

function VBase:draw()
  for i=0;1;#self.ZLayer do
    local l = self.ZLayer[i]
    
  end
end

function VBase:update(dt)

end

function VBase:keypressed(key,scancode,isrepeat)

end

function VBase:keyreleased(key,scancode)

end

function VBase:textinput(text)

end

function VBase:mousepressed(x,y,button,istouch)

end

function VBase:mousereleased(x,y,button,istouch)

end

return VBase