local Path = ...
local Class = require(Path..".third-party.middleclass",Path)

local VBase = Class("view.base") VBase.static.PMUGV = true --P-Mug View Class

function VBase:initialize()
  self.ZLayer = {} --The z dimension of objects.
end

function VBase:draw()

end

function VBase:update(dt)

end

function VBase:keypressed()

end

function VBase:keyreleased()

end

function VBase:textinput()

end

function VBase:mousepressed()

end

function VBase:mousereleased()

end

return VBase