--LoveGlass By: RamiLego4Game--
local loveglass, Path = {}, ...

loveglass.ThemeManager = require(Path..".libraries.ThemeManager")
loveglass.GlassUtil = require(Path..".libraries.GlassUtil")

--Configuration Start--
local DefaultTheme = "Flat"
--Configuration End--

loveglass.GlassUtil:initialize()
loveglass.ThemeManager:setDefaultTheme(DefaultTheme)

function loveglass.event(viewname,objname,cbname,callback)
  if not loveglass.GlassUtil.Events[viewname] then return error("View doesn't exists ("..tostring(viewname)..")") end
  if not loveglass.GlassUtil.Events[viewname][objname] then return error("Object dosn't exists in view "..viewname.." ("..tostring(objname)..")") end
  if not type(callback) == "function" then error("Event callback should be a function (got "..type(callback)..")") end
  loveglass.GlassUtil:registerEventCallback(viewname,objname,cbname,callback)
end

function loveglass.update(dt)
  loveglass.GlassUtil:update(dt)
end

function loveglass.draw()
  loveglass.GlassUtil:drawActiveView()
end

function loveglass.mousepressed(x,y,button)
  loveglass.GlassUtil:mousepressed(x,y,button)
end

function loveglass.mousereleased(x,y,button)
  loveglass.GlassUtil:mousereleased(x,y,button)
end

function loveglass.keypressed(key,isrepeat)
  
end

function loveglass.keyreleased(key)
  
end

function loveglass.textinput(text)
  
end

return loveglass