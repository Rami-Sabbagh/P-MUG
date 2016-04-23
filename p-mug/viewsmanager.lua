local ViewsManager, Path = {Views={}}, ...

local ViewBase = require(Path..".api.viewbase")

function ViewsManager:newView(name,...)
  local newView = ViewBase(name or "none",...)
  self:registerView(newView)
  return newView
end

function ViewsManager:registerView(view)
  if not view.static.PMUGV then return error("This isn't a P-Mug view class") end
  self.View[view:getName()] = view
end

function ViewsManager:setActiveView(name,...)
  if not self.Views[name] then return error("View ["..tostring(name).."] is not registered.") end
  if self.activeView then
    self.activeView:leave(self.Views[name],...)
    self.Views[name]:enter(self.activeView,...)
  else
    self.Views[name]:enter(nil,...)
  end
  self.activeView = self.Views[name]
end

function ViewsManager:draw(...)
  if self.activeView and self.activeView.draw then
    self.activeView:draw(...)
  end
end

function ViewsManager:update(...)
  if self.activeView and self.activeView.update then
    self.activeView:update(...)
  end
end

function ViewsManager:keypressed(...)
  if self.activeView and self.activeView.keypressed then
    self.activeView:keypressed(...)
  end
end

function ViewsManager:keyreleased(...)
  if self.activeView and self.activeView.keyreleased then
    self.activeView:keyreleased(...)
  end
end

function ViewsManager:textinput(...)
  if self.activeView and self.activeView.textinput then
    self.activeView:textinput(...)
  end
end

function ViewsManager:mousepressed(...)
  if self.activeView and self.activeView.mousepressed then
    self.activeView:mousepressed(...)
  end
end

function ViewsManager:mousemoved(...)
  if self.activeView and self.activeView.mousemoved then
    self.activeView:mousemoved(...)
  end
end

function ViewsManager:mousereleased(...)
  if self.activeView and self.activeView.mousereleased then
    self.activeView:mousereleased(...)
  end
end

function ViewsManager:touchpressed(...)
  if self.activeView and self.activeView.touchpressed then
    self.activeView:touchpressed(...)
  end
end

function ViewsManager:touchmoved(...)
  if self.activeView and self.activeView.touchmoved then
    self.activeView:touchmoved(...)
  end
end

function ViewsManager:touchreleased(...)
  if self.activeView and self.activeView.touchreleased then
    self.activeView:touchreleased(...)
  end
end

return ViewsManager