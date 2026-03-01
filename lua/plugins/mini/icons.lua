local P = "mini.icons"

return {
  P,
  lazy = false,
  after = function()
    require(P).setup {}
    MiniIcons.mock_nvim_web_devicons()
  end,
}
