local Path = string.sub(..., 1, -string.len(".themes.Flat"))
local Dir = Path:gsub("(%a)%.(%a)", "%1/%2").."/"
local Font = require(Path..".libraries.Font")
local Flat = {}

Flat.Name = "Flat"
Flat.Author = "RamiLego4Game"
Flat.Version = 0.1

Flat.UI = require(Path..".themes.Flat.UI")

Flat.Fonts = {}
Flat.Fonts.Normal = Font(Dir.."themes/Flat/Fonts/Roboto-Light.ttf")
Flat.Fonts.Bold = Font(Dir.."themes/Flat/Fonts/RobotoCondensed-Bold.ttf")

function Flat.DrawText(Object,Text,X,Y,R,Limit  ,Style,Size,Align,Color)
  love.graphics.setColor(Color or {75,75,75,255})
  local Style = Style or "Normal" love.graphics.setFont(Flat.Fonts[Style][Size])
  local H = Flat.Fonts[Style][Size]:getHeight() love.graphics.printf(Text,X,Y-H/2,Limit,Align or "center" ,R)
end

return Flat