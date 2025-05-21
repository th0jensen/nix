--- Spawn a Ghostty window (400x300, centered) with a single Dock icon.
--- @type fun(): nil
local function spawnGhostty()
  -- Get screen dimensions
  --- @type hs.screen
  local screen = hs.screen.mainScreen()
  --- @type hs.geometry.rect
  local screenFrame = screen:frame()
  local windowWidth = 400
  local windowHeight = 300
  local posX = screenFrame.x + (screenFrame.w - windowWidth) / 2
  local posY = screenFrame.y + (screenFrame.h - windowHeight) / 2

  -- Check if Ghostty is running
  --- @type hs.application?
  local ghosttyApp = hs.application.get("Ghostty")
  if not ghosttyApp then
    -- Launch Ghostty
    hs.application.launchOrFocus("/Applications/Ghostty.app")
    --- @type hs.timer
    hs.timer.doAfter(1, function()
      -- Resize and center after launch
      --- @type hs.window?
      local win = hs.window.focusedWindow()
      if win then
        --- @type hs.geometry.rect
        win:setFrame({ x = posX, y = posY, w = windowWidth, h = windowHeight })
      end
    end)
  else
    -- Create new window with Cmd + n
    ghosttyApp:activate()
    --- @type hs.eventtap.event
    hs.eventtap.keyStroke({ "cmd" }, "n")
    hs.timer.doAfter(0.5, function()
      --- @type hs.window?
      local win = hs.window.focusedWindow()
      if win then
        win:setFrame({ x = posX, y = posY, w = windowWidth, h = windowHeight })
      end
    end)
  end
end

-- Bind to hotkey (Cmd + Shift + G)
--- @type hs.hotkey
hs.hotkey.bind({ "cmd", "shift" }, "G", spawnGhostty)

return {
  spawnGhostty = spawnGhostty,
}
