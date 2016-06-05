local Path = string.sub(..., 1, string.len(...) - string.len(".drawers.debug"))
local Class = require(Path..".third-party.middleclass")
local DBase = require(Path..".api.drawerbase")

local DDebug = Class("drawer.debug",DBase)

local Font = love.graphics.newFont(12)

function DDebug:getName()
  return "Debug"
end

function DDebug:draw_rectangle(shape)
  love.graphics.setColor(255,0,0,255)
  love.graphics.setLineWidth(1)
  love.graphics.rectangle("line",shape:getDrawingArgs())
end

function DDebug:draw_text(shape)
  love.graphics.setColor(255,0,0,255)
  love.graphics.setLineWidth(1)
  love.graphics.setFont(Font)
  love.graphics.printf(shape:getDrawingArgs(Font))
end

return DDebug