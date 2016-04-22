local Path = string.sub(..., 1, string.len(...) - string.len(".libraries.GlassUtil"))
local ThemeManager = require(Path..".libraries.ThemeManager")
local Dir = Path:gsub("(%a)%.(%a)", "%1/%2").."/"
local JSON = require(Path..".third-party.json")
local GlassUtil = {}

GlassUtil.Views = {}

GlassUtil.Events = {}

GlassUtil.ObjectsClasses = {}
GlassUtil.ShapeClasses = {}

function GlassUtil:initialize()
  ThemeManager:loadThemes()
  self:LoadObjectsClasses()
  self:LoadShapeClasses()
end

function GlassUtil:drawView(name)
  for name,object in pairs(self.Views[name]) do
    object:draw()
  end
end

function GlassUtil:update(dt)
  if not self.ActiveView then return end
  local mx, my = love.mouse.getPosition()
  for name,object in pairs(self.Views[self.ActiveView]) do
    object:pointerMoved(0,mx,my,love.mouse.isDown(1) and 1 or 0)
  end
end

function GlassUtil:mousepressed(x,y,button)
  if not self.ActiveView then return end
  for name,object in pairs(self.Views[self.ActiveView]) do
    object:pointerPressed(0,x,y,button)
  end
end

function GlassUtil:mousereleased(x,y,button)
  if not self.ActiveView then return end
  for name,object in pairs(self.Views[self.ActiveView]) do
    object:pointerReleased(0,x,y,button)
  end
end

function GlassUtil:drawActiveView()
  if self.ActiveView then self:drawView(self.ActiveView) end
end

function GlassUtil:setActiveView(name)
  self.ActiveView = name
end

function GlassUtil:fireEvent(viewname,objname,cbname,...)
  if not self.Events[viewname][objname][cbname] then return end
  for k, callback in ipairs(self.Events[viewname][objname][cbname]) do
    callback(...)
  end
end

function GlassUtil:registerEventCallback(viewname,objname,cbname,callback)
  if not self.Events[viewname][objname][cbname] then self.Events[viewname][objname][cbname] = {} end
  self.Events[viewname][objname][cbname][#self.Events[viewname][objname] + 1] = callback
end

function GlassUtil:RegisterObjectClass(name,class)
  self.ObjectsClasses[name] = class
end

function GlassUtil:RegisterShapeClass(class)
  self.ShapeClasses[class.name] = class
end

function GlassUtil:newUIShape(name,themename,args,...)
  if not self.ShapeClasses[name] then return error("Shape "..tostring(name).." Doesn't Exists") end
  local UIShapeClass = self.ShapeClasses[name]
  local UIShape = ThemeManager:applyUIShapeTheme(UIShapeClass,themename,...):setDrawingArgs(args)
  return UIShape
end

function GlassUtil:BuildView(viewdata)
  print("Building View: "..viewdata.Name)
  self.Views[viewdata.Name] = {} self.Events[viewdata.Name] = {}
  if viewdata.Objects then
    for objectname,objectdata in pairs(viewdata.Objects) do
      print("Building Object: "..objectname.." / "..objectdata.Type)
      local Object = self.ObjectsClasses[objectdata.Type](viewdata.Name,objectname) Object:setFontData(objectdata.FontData)
      for name,shapesdata in pairs(objectdata.UIElements) do
        local Shapes = {}
        for id, shapedata in ipairs(shapesdata) do
          table.insert(Shapes,self:newUIShape(shapedata.Name,shapedata.ThemeName,shapedata.Args,unpack(shapedata.Properties)))
        end
        Object:newUIElement(name,unpack(Shapes))
      end
      if objectdata.Properties then
        for key, value in pairs(objectdata.Properties) do
          Object["set"..key](Object,value)
        end
      end
      self.Views[viewdata.Name][objectname] = Object self.Events[viewdata.Name][objectname] = {}
    end
  end
end

function GlassUtil:LoadView(jsondata)
  local Data = JSON:decode(jsondata)
  print("Loaded JsonData For View: "..Data.Name)
  self:BuildView(Data)
end

function GlassUtil:LoadViewsDir(dir)
  print("Loading Views Form The Directory: "..dir)
  local ViewsDir = love.filesystem.getDirectoryItems(dir)
  for k, view in pairs(ViewsDir) do
    if love.filesystem.isDirectory(dir..view) then return end
    print("Found View: "..view)
    local JsonData = love.filesystem.read(dir..view)
    self:LoadView(JsonData)
  end
end

function GlassUtil:LoadObjectsClasses()
  print("Loading Objects Form The Directory: "..Dir.."objects/")
  local ObjectsDir = love.filesystem.getDirectoryItems(Dir.."objects/")
  for k,object in pairs(ObjectsDir) do
    print("Loading Object: "..object.." / "..Path..".objects."..object:sub(1,-5))
    if love.filesystem.isDirectory(Dir.."objects/"..object) then return end
    local Object = require(Path..".objects."..object:sub(1,-5))
    print("Loaded Object: "..Object.name)
    self:RegisterObjectClass(object:sub(1,-5),Object)
  end
end

function GlassUtil:LoadShapeClasses()
  print("Loading Shape Form The Directory: "..Dir.."shapes/")
  local ShapesDir = love.filesystem.getDirectoryItems(Dir.."shapes/")
  for k,shape in ipairs(ShapesDir) do
    print("Loading Shape: "..shape.." / "..Path..".shapes."..shape:sub(1,-5))
    if love.filesystem.isDirectory(Dir.."shapes/"..shape) then return end
    local Shape = require(Path..".shapes."..shape:sub(1,-5))
    print("Loaded Shape: "..Shape.name)
    self:RegisterShapeClass(Shape)
  end
end

return GlassUtil