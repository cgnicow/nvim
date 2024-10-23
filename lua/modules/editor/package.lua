local package = require("core.pack").package
local conf = require("modules.editor.config")

package({
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  build = ":TSUpdate",
  config = conf.nvim_treesitter,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
})

package({
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  config = conf.telescope,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
})

-- package({
--   "folke/flash.nvim",
--   event = "VeryLazy",
--   opts = {},
--   keys = {
--     "f",
--     "F",
--     "t",
--     "T",
--     ";",
--     ",",
--   },
--   config = conf.flash_nvim,
-- })

package({
  "cohama/lexima.vim",
  event = "InsertEnter",
})

package({
  "norcalli/nvim-colorizer.lua",
  event = "InsertEnter",
  config = function()
    require("colorizer").setup()
  end,
})

package({
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup()
  end,
})
