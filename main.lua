io.stdout:setvbuf('no');

local PMug = require("p-mug") --Require PMug Library

function love.load(args)
  love.graphics.setBackgroundColor(PMug.Material.colors.background("light")) --Set the background color

  local Width, Height = love.graphics.getDimensions() --Get the size of the window

  local TView = PMug.newView("test") --Create a new view in PMug, TView -> Test view.

  --Create a button object, TBExit -> Test Button Exit
  --Arguments: x (number), y (number), width (number), height (number), text (string), onClick (function)
  local TBExit = PMug.Object.Material.Button(10,10,100,35,"Quit",function(obj,shapes)
    love.event.quit() --To close the love game..
  end)
  --Create a button to open the Counter Demo Frame, TCButton -> Test Counter Button
  --Arguments: x (number), y (number), width (number), height (number), text (string), onClick (function)
  local TCButton = PMug.Object.Material.Button(10,55,100,35,"Counter",function(obj,shapes)
    --Create a new frame for the counter demo, TFrame -> Test Frame
    --Arguments: x (number), y (number), width (number), height (number), title (string)
    local TFrame = PMug.Object.Material.Frame(100,100,200,200,"Counter Demo")
    --Create a new text object, TText -> Test Text
    --Arguments: text(string), x (number), y (number), width (number), height (number)
    local TText = PMug.Object.Material.Text("0",0,0,200,125)
    local Counter = 0 --The counting variable
    --Create a new button to count up, TFCButton -> Test Frame Counte Button
    --Arguments: x (number), y (number), width (number), height (number), text (string), onClick (function)
    local TFCButton = PMug.Object.Material.Button(90,125,100,35,"Count",function(obj,shapes)
      Counter = Counter+1 --Increase the counter
      TText:setText(tostring(Counter)) --Set the counting number of the text object
    end)
    TFrame:registerObject(TText, 0) --Register The Text Object in the frame (Notice TFrame:), The second arg is the z (depth) position
    TFrame:registerObject(TFCButton,0) --Register The Counting Button in the frame (Notice TFrame:), The second arg is the z (depth) position
    TView:registerObject(TFrame,4) --Register Frame in the view (Notice TView:), The second arg is the z (depth) position
  end)
  local TTBButton = PMug.Object.Material.Button(10,100,100,35,"TextBox",function()
    local TFrame = PMug.Object.Material.Frame(100,100,600,200,"TextBox Demo")
    local TText = PMug.Object.Material.Text("Text",0,0,580,125)
    local TTBox = PMug.Object.Material.TextBox(10,125,580,35,"Text","",function(newtext,obj) TText:setText(newtext) end)
    TFrame:registerObject(TText, 0)
    TFrame:registerObject(TTBox, 0)
    TView:registerObject(TFrame,4)
  end)
  local TSLButton = PMug.Object.Material.Button(10,145,100,35,"Slider",function()
    local TFrame = PMug.Object.Material.Frame(125,125,500,200,"Slider Demo")
    local THText = PMug.Object.Material.Text("0",10,0,200,125)
    local THSlider = PMug.Object.Material.Slider(20,150,180,"h",0,255,function(obj,value)
      THText:setText(tostring(math.floor(value)))
    end)

    local TVText = PMug.Object.Material.Text("0",250,20,200,125)
    local TVSlider = PMug.Object.Material.Slider(480,20,130,"v",0,255,function(obj,value)
      TVText:setText(tostring(math.floor(value)))
    end)

    TFrame:registerObject(THText, 0)
    TFrame:registerObject(THSlider,0)
    TFrame:registerObject(TVText, 0)
    TFrame:registerObject(TVSlider,0)
    TView:registerObject(TFrame,4)
  end)
  local TSPButton = PMug.Object.Material.Button(10,190,100,35,"Spinner",function()
    local TFrame = PMug.Object.Material.Frame(100,100,200,200,"Spinner Demo")
    local TSpinner = PMug.Object.Material.Spinner(100,85,20,5)
    TFrame:registerObject(TSpinner,0)
    TView:registerObject(TFrame,4)
  end)

  local FABButton = PMug.Object.Material.FAB(Width-50,Height-50,"github-circle","blue-grey",false,function()
    love.system.openURL("http://github.com/RamiLego4Game/p-mug")
  end)
  TView:registerObject(TBExit,0):registerObject(TCButton,0):registerObject(TTBButton,0):registerObject(TSLButton,0):registerObject(TSPButton,0):registerObject(FABButton,4)
  PMug.setActiveView("test")
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
