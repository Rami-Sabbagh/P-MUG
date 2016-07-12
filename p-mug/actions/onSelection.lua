local Path = string.sub(..., 1, -string.len(".actions.onSelection"))
local Class = require(Path..".third-party.middleclass")
local ABase = require(Path..".api.actionbase")

local AOS = Class("action.onSelection",ABase)

function AOS:initialize(onselected,ondeselected)
  ABase.initialize(self)
  self.os = onselected or function() end
  self.ods = ondeselected or function() end
end

function AOS:setOnSelected(func)
  self.os = func or function() end
end

function AOS:setOnDeSelected(func)
  self.ods = func or function() end
end

function AOS:selected(obj)
  return self.os(obj)
end

function AOS:deselected(obj)
  return self.ods(obj)
end

return AOS