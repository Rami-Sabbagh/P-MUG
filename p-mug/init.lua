--P-MUG By: RamiLego4Game--
local PMug, Path = {Views={},Shape={},Drawer={}}, ...

local ViewBase = require(Path..".api.viewbase")

function PMug.splitFilePath(path)
  return path:match("(.-)([^\\/]-%.?([^%.\\/]*))$")
end

function PMug.indexShapes(path)
  local files = love.filesystem.getDirectoryItems(path)
  for k,filename in ipairs(files) do
    if love.filesystem.isDirectory(path..filename) then
      PMug.indexShapes(path..filename.."/")
    else
      local p, n, e = PMug.splitFilePath(path..filename)
      n = n:sub(0,-5)
      if e == "lua" then
        PMug.Shape[n] = require(string.gsub(path..n,"/","%."))
      end
    end
  end
end

function PMug.indexDrawers(path)
  local files = love.filesystem.getDirectoryItems(path)
  for k,filename in ipairs(files) do
    if love.filesystem.isDirectory(path..filename) then
      PMug.indexDrawers(path..filename.."/")
    else
      local p, n, e = PMug.splitFilePath(path..filename)
      n = n:sub(0,-5)
      if e == "lua" then
        PMug.Drawer[n] = require(string.gsub(path..n,"/","%."))
      end
    end
  end
end

PMug.indexShapes(Path:gsub("%.", "/").."/shapes/")
PMug.indexDrawers(Path:gsub("%.", "/").."/drawers/")

function PMug.newView(name,...)
  local newView = ViewBase(name or "none",...)
  PMug.registerView(newView)
  return newView
end

function PMug.newDrawer()
  
end

function PMug.newBhavior()
  
end

function PMug.newShape()
  
end

function PMug.registerView(view)
  if not view.PMUGV then return error("This isn't a P-Mug view class") end
  PMug.Views[view:getName()] = view
end

function PMug.setActiveView(name,...)
  if not PMug.Views[name] then return error("View ["..tostring(name).."] is not registered.") end
  if PMug.activeView then
    PMug.activeView:leave(PMug.Views[name],...)
    PMug.Views[name]:enter(PMug.activeView,...)
  else
    PMug.Views[name]:enter(nil,...)
  end
  PMug.activeView = PMug.Views[name]
end

function PMug.draw(...)
  if PMug.activeView and PMug.activeView.draw then
    PMug.activeView:draw(...)
  end
end

function PMug.update(...)
  if PMug.activeView and PMug.activeView.update then
    PMug.activeView:update(...)
  end
end

function PMug.keypressed(...)
  if PMug.activeView and PMug.activeView.keypressed then
    PMug.activeView:keypressed(...)
  end
end

function PMug.keyreleased(...)
  if PMug.activeView and PMug.activeView.keyreleased then
    PMug.activeView:keyreleased(...)
  end
end

function PMug.textinput(...)
  if PMug.activeView and PMug.activeView.textinput then
    PMug.activeView:textinput(...)
  end
end

function PMug.mousepressed(...)
  if PMug.activeView and PMug.activeView.mousepressed then
    PMug.activeView:mousepressed(...)
  end
end

function PMug.mousemoved(...)
  if PMug.activeView and PMug.activeView.mousemoved then
    PMug.activeView:mousemoved(...)
  end
end

function PMug.mousereleased(...)
  if PMug.activeView and PMug.activeView.mousereleased then
    PMug.activeView:mousereleased(...)
  end
end

function PMug.touchpressed(...)
  if PMug.activeView and PMug.activeView.touchpressed then
    PMug.activeView:touchpressed(...)
  end
end

function PMug.touchmoved(...)
  if PMug.activeView and PMug.activeView.touchmoved then
    PMug.activeView:touchmoved(...)
  end
end

function PMug.touchreleased(...)
  if PMug.activeView and PMug.activeView.touchreleased then
    PMug.activeView:touchreleased(...)
  end
end

return PMug