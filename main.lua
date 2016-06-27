--e "io.stdout:setvbuf('no'); if os.getenv('DEBUG_MODE') then require 'debugger' ; require 'debugger.plugins.ffi'end"
io.stdout:setvbuf('no'); --if os.getenv('DEBUG_MODE') then require 'debugger' ; require 'debugger.plugins.ffi'end
if os.getenv('DEBUG_MODE') then require('debugger')() ; end--require('debugger.plugins.ffi') end
--io.stdout:setvbuf("no")

local PMug = require("p-mug")
local OBase = require("p-mug.api.objectbase")
local HBase = require("p-mug.api.handlerbase")

local Material = require("p-mug.third-party.material-love")

function love.load(args)
  --if args[2] and args[2] == "-e" then loadstring(args[3])() end
  love.graphics.setBackgroundColor(Material.colors.background("light"))
  local TView = PMug.newView("test")
  local TBExit = PMug.Object.button(10,10,100,35,"Quit",function() love.event.quit() end)
  local TButton = PMug.Object.button(10,55,100,35,"New Frame",function()
    local TFrame = PMug.Object.frame(100,100,200,200,"Frame Test")
    local TText = PMug.Object.text("0",0,0,200,125)
    local Counter = 0
    local TTButton = PMug.Object.button(90,125,100,35,"Count",function(obj,shapes) Counter = Counter+1 TText:setText(tostring(Counter))  end)
    TFrame:registerObject(TText, 0)
    TFrame:registerObject(TTButton,0)
    TView:registerObject(TFrame,4)
  end)
  TView:registerObject(TBExit,0):registerObject(TButton,0)
  PMug.setActiveView("test")
  generateColorPallete()
end

function toColor(num)
  if num < 100 then return " "..tostring(num) elseif num < 10 then return "  "..tostring(num) else return tostring(num) end
end

function generateColorPallete()
  local data = "GIMP Palette\nName: Material Auto\nColumns: 21\n#\n"
  local colors = {"red","pink","purple","deep-purple","indigo","blue","light-blue","cyan","teal","green","light-green","lime","yellow","amber","orange","deep-orange","brown","grey","blue-grey"}
  local maincolors = {"50","100","200","300","400","500","600","700","800","900","a100","a200","a400","a700"}
  local bwcolors = {"full","divider","disabled","inactive-icon","hint-text","secondary-text","icon","text","display","headline","title","subhead","body","caption","menu","button"}
  for k,cl in ipairs(colors) do
    local r, g, b = Material.colors.main(cl)
    r, g, b = toColor(r), toColor(g), toColor(b)
    data = data..r.." "..g.." "..b.."    "..cl.." main"
  end
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

function love.mousemoved(x,y,dx,dy,istouch)
  PMug.mousemoved(x,y,dx,dy,istouch)
end

function love.mousereleased(x,y,button,istouch)
  PMug.mousereleased(x,y,button,istouch)
end

function love.touchpressed(id,x,y,dx,dy,pressure)
  PMug.touchpressed(id,x,y,dx,dy,pressure)
end

function love.touchmoved(id,x,y,dx,dy,pressure)
  PMug.touchmoved(id,x,y,dx,dy,pressure)
end

function love.touchreleased(id,x,y,dx,dy,pressure)
  PMug.touchreleased(id,x,y,dx,dy,pressure)
end

function love.keypressed(key,scancode,isrepeat)
  PMug.keypressed(key,scancode,isrepeat)
end

function love.keyreleased(key,scancode)
  PMug.keyreleased(key,scancode)
end

function love.textinput(text)
  PMug.textinput(text)
end