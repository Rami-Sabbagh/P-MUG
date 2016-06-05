local Path = string.sub(..., 1, string.len(...) - string.len(".drawers.debug"))
local Class = require(Path..".third-party.middleclass")
local DBase = require(Path..".api.drawerbase")

local DDebug = Class("drawer.debug",DBase)

return DDebug