# P-MUG
[W.I.P] Pocket's Material User Graphical Interface library for LÖVE 0.10.1

## How to run the current demo:
Download the repository and run it using love 0.10.1 (extract it and run the folder with main.lua ..)

For android extract the repository and copy all the files in the main.lua folder and paste them in lovegame folder at the root of your sdcard, then run love 0.10.1 for android.

## How objects are constructed in P-Mug:
Objects in PMug are made in a complex way that makes it easier to handler touch&mouse event.

Objects are consisted of 4 different classes:
- Shapes: They are like blocks to construct the building (The object).
- Handlers: They are responsible for handling the mouse, touch and keyboard events.
- Actions: Those are called by handlers, and they do the specific things objects have to do, like calling onClick function, or dragging the objects like in frames.
- Drawers: Those are responsible for drawing shapes, with custom styling applied.

## Building a button object:
1. First begin by creating a new object:
```lua
local PMug = require("p-mug")
local newObject = PMug.ObjectBase()
```
2. Create the body shape:
```lua
local bodyShape = PMug.Shape.rectangle(0,0,200,30) --X, Y, Width, Height
```
3. Customize the body shape style:
```lua
bodyShape:setDrawingArgs(false,false,{PMug.Material.colors("grey","200")})
--[[The first false is to enable shadows, the second one is to enable expand effect for the shape, the third is the color of the ripple,
See the drawing arguments documentation for the rectangle shape in p-mug/drawers/material.lua
For material api documentation see https://github.com/Positive07/material-love/wiki]]
```

4. Create text shape:
```lua
local textShape = PMug.Shape.textrect("Click Me",0,0,200,30,"center")
--[[
PMug.Shape.textrect(text, x, y, w, h, align)
text: String: the text to show on the button.
x: Number: The x position of the shape in the object.
y: Number: The y position of the shape in the object.
w: Number: The width of the text rectangle box.
h: Number: The height of the text rectangle box.
align: String: the align mode for the text, the same of love's ones.
]]
```

5. Customize the textrect shape style:
```lua
textShape:setDrawingArgs("button",{Material.colors.main("blue")})
--[[
The first false is the size of text font, look in material-love documentation, the second one is the color of the text,
See the drawing arguments documentation for the textrect shape in p-mug/drawers/material.lua
]]
```

6. Create a drawer to draw the shapes:
```lua
local Drawer = PMug.Drawer.material()
```

7. Add the shapes to the drawer, they work like layers:
```lua
Drawer:linkShape(bodyShape):linkShape(textShape)
--[[
The first linked shapes first, so body is drawn then the text, so the text is about the body.
]]
```

8. Create a handler for the button:
```lua
local Handler = PMug.Handler()
```

9. Link the shapes to the handler:
```lua
Handler:linkShape(bodyShape):linkShape(textShape)
```

10. Create an onclick action:
```lua
local onClickAct = PMug.Action.onClick(function() print("Button clicked") end)
```

11. Create an update state action for the shapes:
```lua
local updateStateAct = PMug.Action.updateState()
```

12. Add the actions to the handler:
```lua
Handler:addAction(onClickAct):addAction(updateStateAct)
```

13. Register everything:
```lua
newObject:addDrawer(Drawer):addHandler(Handler)
newObject:registerShape(bodyShape):registerShape(textShape)
```

14. Set the position of the object:
```lua
newObject:setPosition(x,y)
```

15. That's it, now look at other objects code in p-mug/objects/Material

## Current list of features:
- Material design :3
- Supports Windows, Linux, OS X, iOS and Android
- Supports Multi-Touch
- Runs on LOVE 0.10.1
- Real circle buttons
- Objects are easy to create

## Current list of objects:
- Button
- Frame
- Text
- TextBox
- FAB Button

## TODO List:
- Create spinner object
- Create slider object
- Create checkbox object
- Upgrade ContainerBase to support lists
- Create list object
- Create progress bar object
- Build smart sizing & positions system
- Document the code
- Pre-Release the library
