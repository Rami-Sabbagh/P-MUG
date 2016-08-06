--[[SmartStencil Library made specially for P-Mug Library
Allow the stacking of stencils, giving the ability to stack lists in lists
Stacking Limits to 255 (LOVE Limits to that number)]]

local stencilFunctions = {}
local stencilCount = 0

function stencil(func)
  if func then
    stencilCount = stencilCount + 1
    stencilFunctions[stencilCount] = func
    love.graphics.setStencilTest("equal", stencilCount)
    love.graphics.stencil(stencilFunctions[stencilCount], "increment", false, true)
  else
    love.graphics.stencil(stencilFunctions[stencilCount], "decrement", false, true)
    stencilFunctions[stencilCount] = false
    stencilCount = stencilCount - 1
    if stencilCount == 0 then
      love.graphics.setStencilTest()
    else
      love.graphics.setStencilTest("equal", stencilCount)
    end
  end
end

return stencil
