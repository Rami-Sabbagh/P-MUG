local Path = string.sub(..., 1, string.len(...) - string.len(".api.objectbase"))
local Class = require(Path..".third-party.middleclass")

local OBase = Class("view.base") OBase.PMUGO = true --P-Mug Object Class

function OBase:registerDrawer()

end

function OBase:registerBhavior()

end

function OBase:registerShape()

end

return OBase