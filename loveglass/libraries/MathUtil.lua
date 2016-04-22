local MathUtil = {}

--Calculates the distance between 2 points.
function MathUtil.calcDistance(x1,y1,x2,y2)
  return math.sqrt(((x1-x2)^2)+((y1-y2)^2))
end

function MathUtil.combineRects(...)
  local RectsArgs = {...}
  local Rects = {}
  for k = 1, #RectsArgs, 4 do
    local Rect = {}
    Rect.x1 = RectsArgs[k]
    Rect.y1 = RectsArgs[k+1]
    Rect.x2 = Rect.x1 + RectsArgs[k+2]
    Rect.y2 = Rect.y1 + RectsArgs[k+3]
    table.insert(Rects,Rect)
  end
  
  local function minArg(arg)
    local Args = {}
    for k,v in ipairs(Rects) do
      table.insert(Args,v[arg])
    end
    return math.min(unpack(Args))
  end
  
  local function maxArg(arg)
    local Args = {}
    for k,v in ipairs(Rects) do
      table.insert(Args,v[arg])
    end
    return math.max(unpack(Args))
  end
  
  return minArg("x1"), minArg("y1"), maxArg("x2")-minArg("x1"), maxArg("y2")-minArg("y1")
end

return MathUtil