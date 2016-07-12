local Path = string.sub(..., 1, -string.len(".actions.onClick"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")

local AOC = Class("action.onClick",ABase)

function AOC:initialize(onclick)
  ABase.initialize(self)
  self.oc = onclick or function() end
end

function AOC:setOnClick(oc)
  self.oc = oc or function() end
end

function AOC:handlerReleased(x,y,pressure,obj,shape,shapes,obstruct)
  if obstruct then return end
  self.oc(obj,shapes)
end

return AOC