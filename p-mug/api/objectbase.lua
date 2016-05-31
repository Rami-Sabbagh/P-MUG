local Path = string.sub(..., 1, string.len(...) - string.len(".api.objectbase"))
local Class = require(Path..".third-party.middleclass")

local OBase = Class("object.base") OBase.PMUGO = true --P-Mug Object Class

function OBase:addDrawer()

end

function OBase:addBhavior()

end

function OBase:registerShape()

end

return OBase