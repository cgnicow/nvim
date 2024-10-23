local package = require("core.pack").package
local conf = require("modules.tools.config")

package({
  "nvimdev/guard.nvim",
  ft = { "c", "cpp", "h", "hpp", "rust", "lua", "python", "asm" },
  config = conf.guard,
  dependencies = {
    { "nvimdev/guard-collection" },
  },
})

--  package({
--    "nvimdev/dyninput.nvim",
--    ft = { "c", "cpp", "rust", "lua" },
--    config = conf.dyninput,
--    dependencies = "nvim-treesitter/nvim-treesitter"
--  })

package({
  "ii14/emmylua-nvim",
  ft = "lua",
})

package({
  "mrcjkb/rustaceanvim",
  version = "^3", -- recommended
  ft = "rust",
})

package({
  "nvimdev/hlsearch.nvim",
  event = "BufRead",
  config = function()
    require("hlsearch").setup()
  end,
})

package({
  "nvimdev/rapid.nvim",
  cmd = "Rapid",
  config = function()
    require("rapid").setup()
  end,
})
