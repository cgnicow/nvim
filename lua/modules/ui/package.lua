local package = require("core.pack").package
local conf = require("modules.ui.config")

package({
  "DanielEliasib/sweet-fusion",
  lazy = false,
  name = "sweet-fusion",
  priority = 1000,
  config = conf.sweet,
})

package({
  "Skullamortis/forest.nvim",
  lazy = false,
  priority = 1000,
  config = conf.forest,
})

package({
  "water-sucks/darkrose.nvim",
  lazy = false,
  priority = 1000,
  config = conf.darkrose,
})

package({
  "hachy/eva01.vim",
  lazy = false,
  priority = 1000,
  config = function()
    -- vim.cmd([[colorscheme eva01]])
  end,
})

package({
  "zootedb0t/citruszest.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("citruszest").setup()
    -- vim.cmd([[colorscheme citruszest]])
  end,
})

package({
  "nonetallt/vim-neon-dark",
  lazy = false,
  priority = 1000,
  config = function()
    require("vim-neon-dark").setup()
    -- vim.cmd([[colorscheme neon-dark]])
  end,
})

package({
  "xiyaowong/transparent.nvim",
  lazy = false,
  priority = 1000,
  config = conf.transparent,
})

package({
  "lewis6991/gitsigns.nvim",
  event = { "BufRead", "BufNewFile" },
  config = conf.gitsigns,
})

package({
  "lukas-reineke/indent-blankline.nvim",
  event = "BufEnter",
  main = "ibl",
  config = conf.indent_blankline,
})

package({
  "folke/zen-mode.nvim",
  config = conf.zen,
})
