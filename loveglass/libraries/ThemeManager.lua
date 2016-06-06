local Path = string.sub(..., 1, -string.len(".libraries.ThemeManager"))
local Dir = Path:gsub("(%a)%.(%a)", "%1/%2").."/"
local ThemeManager =  {Themes = {}}

function ThemeManager:loadThemes()
  print("Loading Themes Form The Directory: "..Dir.."themes/")
  local ThemesDir = love.filesystem.getDirectoryItems(Dir.."themes/")
  for k,dir in pairs(ThemesDir) do
    print("Loading Theme: "..dir.." / "..Path..".themes."..dir)
    if love.filesystem.isFile(Dir.."themes/"..dir) then return end
    local Theme = require(Path..".themes."..dir)
    print("Loaded Theme: "..tostring(Theme.Name).." - "..tostring(Theme.Author).." - V"..tostring(Theme.Version))
    self.Themes[Theme.Name] = Theme
  end
end

function ThemeManager:printText(Object,Text,X,Y,R,Limit,ThemeName,...)
  local UITheme = self:getTheme(ThemeName)
  if UITheme.DrawText then
    UITheme.DrawText(Object,Text,X,Y,R,Limit,...)
  else
    UITheme = self:getDefaultTheme()
    UITheme.DrawText(Object,Text,X,Y,R,Limit,...)
  end
end

function ThemeManager:applyUIShapeTheme(shapeclass,themename,...)
  local UITheme = self:getTheme(themename)
  if UITheme.UI and UITheme.UI[shapeclass.name] then
    local newClass = shapeclass:subclass(shapeclass.name..themename)
    newClass:include(UITheme.UI[shapeclass.name])
    return newClass(...)
  else
    UITheme = self:getDefaultTheme()
    local newClass = shapeclass:subclass(shapeclass.name..self.DefaultTheme)
    newClass:include(UITheme.UI[shapeclass.name])
    return newClass(...)
  end
end

function ThemeManager:getTheme(name)
  return self.Themes[name] or self:getDefaultTheme()
end

function ThemeManager:setDefaultTheme(name)
  self.DefaultTheme = name
end

function ThemeManager:getDefaultTheme()
  return self.Themes[self.DefaultTheme]
end

return ThemeManager