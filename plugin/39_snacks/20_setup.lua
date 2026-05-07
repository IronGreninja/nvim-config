Config.now(function() -- some plugins require early setup
  Util.plugAdd "folke/snacks.nvim"
  require("snacks").setup(Config.SnacksOpts)
  Config.SnacksOpts = nil -- delete after setup
end)
