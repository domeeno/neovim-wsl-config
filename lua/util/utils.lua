-- Okay, this is a helper utils.lua inspired from https://github.com/LazyVim/LazyVim.git
-- lua/lazyvim/util/plugin.lua
-- Helps some plugins to be more performant on events of event = { "BufReadPost"vvvvufWritePost", "BufNewFile" } and others

local U = {}

U.lazy_file_events = { "BufReadPost", "BufWritePost", "BufNewFile" }

function U.setup()
  M.lazy_file()
end

function U.lazy_file()
  -- Add support for the LazyFile event
  local Event = require("lazy.core.handler.event")

  Event.mappings.LazyFile = { id = "LazyFile", event = U.lazy_file_events }
  Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end
