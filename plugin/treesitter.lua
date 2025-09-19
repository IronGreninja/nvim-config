require("lz.n").load {
  "nvim-treesitter",
  event = "DeferredUIEnter",
  before = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
  after = function()
    require("nvim-treesitter.configs").setup {
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = false },
    }
  end,
}
