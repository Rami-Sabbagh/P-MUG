local Path = string.sub(..., 1, string.len(...) - string.len(".api.shapebase"))
local Class = require(Path..".third-party.middleclass")

local SBase = Class("drawer.base") SBase.PMUGS = true --P-Mug Shape Class

return SBase