--Use local myFont = Font(filename) then love.graphics.setFont(myFont[size])

local font = {}

local fontmeta = {}
fontmeta.__call = function(t,filename)
  local newfont = {filename = filename}
  local newfontmeta = {}
  
  newfontmeta.__index = function(t,k)
    t[k] = love.graphics.newFont(t.filename,k);
    return t[k]
  end
  
  setmetatable(newfont,newfontmeta) 
  
  return newfont
end

setmetatable(font,fontmeta)

return font