local package = require("core.pack").package
local conf = require("modules.completion.config")

local function lsp_fts(type)
  type = type or nil
  local fts = {}
  fts.backend = {
    "lua",
    "nasm",
    "asm",
    "s",
    "S",
    "sh",
    "rust",
    "c",
    "cpp",
    "zig",
    "python",
  }

  fts.frontend = {
    "json",
  }
  if not type then
    return vim.list_extend(fts.backend, fts.frontend)
  end
  return fts[type]
end

package({
  "hrsh7th/nvim-cmp",
  event = "LspAttach",
  config = conf.nvim_cmp,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = "make install_jsregexp",
      dependencies = "rafamadriz/friendly-snippets",
      config = conf.luasnip,
    },
    "onsails/lspkind.nvim",
  },
})

package({
  "neovim/nvim-lspconfig",
  ft = lsp_fts(),
  config = conf.nvim_lsp,
})

package({
  "nvimdev/lspsaga.nvim",
  ft = lsp_fts(),
  event = "LspAttach",
  config = conf.lspsaga,
})

package({
  "ziglang/zig.vim",
  ft = lsp_fts(),
})
