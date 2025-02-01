{ config, lib, pkgs, ... }:

{
  home.file.".hammerspoon/init.lua".text = ''
    -- Initialize Hammerspoon
    hs.window.animationDuration = 0
    hs.window.setShadows(false)

    -- Watch for new windows and disable their shadows
    local windowWatcher = hs.window.filter.new(true)
    windowWatcher:subscribe(hs.window.filter.windowCreated, function(window)
      if window and window.setShadows then
        window:setShadows(false)
      end
    end)

    -- Reload config automatically
    function reloadConfig(files)
      local doReload = false
      for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
          doReload = true
        end
      end
      if doReload then
        hs.reload()
      end
    end

    local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
    hs.alert.show("Hammerspoon config loaded")

    -- Add your Hammerspoon configurations here
    -- Example: Window Management
    local hyper = {"cmd", "alt", "ctrl"}

    -- Move window to the left half
    hs.hotkey.bind(hyper, "Left", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      win:setFrame(f)
    end)

    -- Move window to the right half
    hs.hotkey.bind(hyper, "Right", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x + (max.w / 2)
      f.y = max.y
      f.w = max.w / 2
      f.h = max.h
      win:setFrame(f)
    end)
  '';
}