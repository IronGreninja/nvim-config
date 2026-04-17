-- Statusline. Sets `:h 'statusline'` to show more info in a line below window.
-- Layout of sections:
-- - Left most -> current mode (text + highlighting).
-- - 2nd from left -> "developer info": Git( ...), diff( ...), diagnostics( ...), LSP(󰰎 +...(no of lsp servers attached)).
-- - 3rd from left -> filename
-- - Right most -> current cursor coordinates.
-- - 2nd to right -> fileinfo
-- - 3rd to right -> search result(searchcount)
--
-- See also:
-- - `:h MiniStatusline-example-content` - example of default content. Use it to
--   configure a custom statusline by setting `config.content.active` function.
-- Extra help: https://deepwiki.com/nvim-mini/mini.statusline/9-examples-and-recipes

Config.now(function()
  local statusline = require "mini.statusline"
  local custom_section_location = function(args)
    -- Use virtual column number to allow update when past last column
    if statusline.is_truncated(args.trunc_width) then return "%l:%2v" end
    -- Use `virtcol()` to correctly handle multi-byte characters
    return '%l/%L:%2v/%-2{virtcol("$") - 1}'
  end

  local custom_statusline = function()
    local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
    local git = statusline.section_git { trunc_width = 40 }
    local diff = statusline.section_diff { trunc_width = 75 }
    local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
    local lsp = statusline.section_lsp { trunc_width = 75 }
    local filename = statusline.section_filename { trunc_width = 140 }
    local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
    local location = custom_section_location { trunc_width = 75 }
    local search = statusline.section_searchcount { trunc_width = 75 }

    return statusline.combine_groups {
      { hl = mode_hl, strings = { mode } },
      { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
      "%<", -- Mark general truncate point
      { hl = "MiniStatuslineFilename", strings = { filename } },
      "%=", -- End left alignment
      { hl = "MiniStatuslineFilename", strings = { search } },
      { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
      { hl = mode_hl, strings = { location } },
    }
  end

  statusline.setup {
    content = { active = custom_statusline },
  }
end)
