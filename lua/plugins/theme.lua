return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {},
  init = function()
    vim.cmd.colorscheme "tokyonight-night"
  end,
}
