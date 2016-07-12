local Path = string.sub(..., 1, -string.len(".api.viewbase"))
local Class = require(Path..".third-party.middleclass")

local CBase = require(Path..".api.containerbase")

local VBase = Class("view.base",CBase) VBase.PMUGV = true --P-Mug View Class

function VBase:initialize(name)
  self.VName = name --The view name.
  CBase.initialize(self)
end

function VBase:getName()
  return self.VName
end

function VBase:enter(prevView,...)
  
end

function VBase:leave(nextView,...)
  
end

return VBase