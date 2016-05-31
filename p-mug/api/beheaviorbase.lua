local Path = string.sub(..., 1, string.len(...) - string.len(".api.beheaviorbase"))
local Class = require(Path..".third-party.middleclass")

local BBase = Class("beheavior.base") BBase.PMUGB = true --P-Mug Beheavior Class

return BBase