--P-MUG By: RamiLego4Game--
local PMug, Path = {activeView=false,Views={},Shape={},Drawer={},Object={},Action={},Design={}}, ...

PMug.Material = require(Path..".third-party.material-love")

love.keyboard.setKeyRepeat(true)

local ViewBase = require(Path..".api.viewbase")
PMug.Handler = require(Path..".api.handlerbase")
PMug.ObjectBase = require(Path..".api.objectbase")

if love.system.getOS() == "Android" or love.system.getOS() == "iOS" then
  PMug.isMobile = true
end

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

function PMug.indexObjects(path,designName)
  local files = love.filesystem.getDirectoryItems(path)
  for k,filename in ipairs(files) do
    if love.filesystem.isDirectory(path..filename) then
      if designName then
        PMug.indexObjects(path..filename.."/",designName)
      else
        PMug.Object[filename] = {}
        PMug.indexObjects(path..filename.."/",filename)
      end
    else
      local p, n, e = PMug.splitFilePath(path..filename)
      n = n:sub(0,-5)
      if e == "lua" then
        if designName then
          PMug.Object[designName][n] = require(string.gsub(path..n,"/","%."))
        else
          PMug.Object[n] = require(string.gsub(path..n,"/","%."))
        end
      end
    end
  end
end

function PMug.indexActions(path)
  local files = love.filesystem.getDirectoryItems(path)
  for k,filename in ipairs(files) do
    if love.filesystem.isDirectory(path..filename) then
      PMug.indexShapes(path..filename.."/")
    else
      local p, n, e = PMug.splitFilePath(path..filename)
      n = n:sub(0,-5)
      if e == "lua" then
        PMug.Action[n] = require(string.gsub(path..n,"/","%."))
      end
    end
  end
end

PMug.indexShapes(Path:gsub("%.", "/").."/shapes/")
PMug.indexDrawers(Path:gsub("%.", "/").."/drawers/")
PMug.indexObjects(Path:gsub("%.", "/").."/objects/")
PMug.indexActions(Path:gsub("%.", "/").."/actions/")

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

local PMugMeta = {}

PMugMeta.__index = function(t,k)
  t[k] = function(...)
    if PMug.activeView and PMug.activeView[k] then
      PMug.activeView[k](PMug.activeView,...)
    end
  end
  return t[k]
end

setmetatable(PMug,PMugMeta)

return PMug
