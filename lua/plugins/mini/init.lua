local this = "plugins.mini."

local Mini = {}

Mini.comment = {}

Mini.surround = {}

Mini.pairs = {
  opts = {
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_unbalanced = true,
    markdown = true,
  },
  after = require(this .. "pairs"),
}

local M = {}

for k, v in pairs(Mini) do
  local plug = "mini." .. k
  table.insert(M, {
    plug,
    event = "DeferredUIEnter",
    after = function()
      local opts = v.opts or {}
      require(plug).setup(opts)
      if v.after and type(v.after) == "function" then
        v.after(opts)
      end
    end,
  })
end

return M
