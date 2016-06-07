local Path = string.sub(..., 1, -string.len(".drawers.debug"))
local Class = require(Path..".third-party.middleclass")
local DBase = require(Path..".api.drawerbase")

local DDebug = Class("drawer.debug",DBase)

local Font = love.graphics.newFont(12)

function DDebug:getName()
  return "Debug"
end

function DDebug:draw_rectangle(shape)
  local isHovered = shape:isHovered()
  local isDown = shape:isDown()
  if isDown then
    love.graphics.setColor(0,255,0,255)
  elseif isHovered then
    love.graphics.setColor(0,0,255,255)
  else
    love.graphics.setColor(255,0,0,255)
  end
  love.graphics.setLineWidth(1)
  love.graphics.rectangle("line",shape:getDrawingArgs())
end

function DDebug:draw_text(shape)
  local isHovered = shape:isHovered()
  local isDown = shape:isDown()
  if isDown then
    love.graphics.setColor(0,255,0,255)
  elseif isHovered then
    love.graphics.setColor(0,0,255,255)
  else
    love.graphics.setColor(255,0,0,255)
  end
  love.graphics.setLineWidth(1)
  love.graphics.setFont(Font)
  love.graphics.printf(shape:getDrawingArgs(Font))
end

return DDebug