io.stdout:setvbuf("no")

local PMug = require("p-mug")

function love.load(args)
  love.graphics.setBackgroundColor(250,250,250)
end

function love.update(dt)
  PMug.update(dt)
end

function love.draw()
  PMug.draw()
end

function love.mousepressed(x,y,button,istouch)
  PMug.mousepressed(x,y,button,istouch)
end

function love.mousereleased(x,y,button,istouch)
  PMug.mousereleased(x,y,button,istouch)
end

function love.keypressed(key,isrepeat)
  PMug.keypressed(key,isrepeat)
end

function love.keyreleased(key)
  PMug.keyreleased(key)
end

function love.textinput(text)
  PMug.textinput(text)
end