do
  -- Set up a global in a way that also handles non-nix compat
  local ok
  ok, _G.nixInfo = pcall(require, vim.g.nix_info_plugin_name)
  if not ok then
    package.loaded[vim.g.nix_info_plugin_name] = setmetatable({}, {
      __call = function(_, default) return default end,
    })
    _G.nixInfo = require(vim.g.nix_info_plugin_name)
    -- If the fetcher function is used to fetch nix values,
    -- rather than indexing into the tables directly,
    -- it will use the value specified as the default
  end

  nixInfo.isNix = vim.g.nix_info_plugin_name ~= nil

  -- override vim.fn.stdpath for 'config'
  local original_stdpath = vim.fn.stdpath
  vim.fn.stdpath = function(what)
    if nixInfo.isNix and what == "config" then
      return nixInfo.settings.config_directory
    end
    return original_stdpath(what)
  end

  function nixInfo.get_nix_plugin_path(name)
    return nixInfo(nil, "plugins", "lazy", name)
      or nixInfo(nil, "plugins", "start", name)
  end
end

-- Define config table to be able to pass data between scripts
-- It is a global variable which can be use both as `_G.Config` and `Config`
_G.Config = {}
_G.Util = {} -- store utils

-- given '<owner>/<repo>', returns a fully qualified github url string
Util.ghSrc = function(r) return "https://github.com/" .. r end

-- name: github plugin source in the format '<owner>/<repo>'
Util.plugAdd = function(name)
  if nixInfo.isNix then
    local pname = vim.split(name, "/")[2]
    vim.cmd.packadd(pname)
  else
    vim.pack.add { Util.ghSrc(name) }
  end
end

-- Load 'mini.nvim' now to have 'mini.misc' available for custom loading helpers.
Util.plugAdd "nvim-mini/mini.nvim"

local misc = require "mini.misc"
Config.now = function(f) misc.safely("now", f) end
Config.later = function(f) misc.safely("later", f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f) misc.safely("event:" .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

-- Define custom autocommand group and helper to create an autocommand.
local gr = vim.api.nvim_create_augroup("custom-config", {})
Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- Custom helper to create user commands
Config.new_usercmd = function(name, cmd, opts)
  vim.api.nvim_create_user_command(name, cmd, opts or {})
end

-- Define custom `vim.pack.add()` hook helper. Plugin data is passed as
-- argument to the callback. See `:h vim.pack-events`.
Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback(ev.data)
  end
  Config.new_autocmd("PackChanged", "*", f, desc)
end
