local Path = string.sub(..., 1, -string.len(".api.handlerbase"))
local Class = require(Path..".third-party.middleclass")

local ABase = Class("action.base") ABase.PMUGA = true --P-Mug Action Class

return ABase