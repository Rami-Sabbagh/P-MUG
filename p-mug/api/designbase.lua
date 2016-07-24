local Path = string.sub(..., 1, -string.len(".api.designbase"))
local Class = require(Path..".third-party.middleclass")

local DSBase = Class("design.base") DSBase.PMUGDS = true --P-Mug Design Class

function DSBase:initialize()
  
end

function DSBase:getName()
  return "Base"
end

function DSBase:buildObject(obj,...)
  local T = obj:getType()
  if self["build"..T] then self["build"..T](self,obj,...) end
end

return DSBase