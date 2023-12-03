local package = require('core.pack').package
local conf = require('modules.completion.config')

package({
  'neovim/nvim-lspconfig',
  -- used filetype to lazyload lsp
  -- config your language filetype in here
  ft = { 'lua', 'rust', 'c', 'nasm', 'bash' },
  config = conf.nvim_lsp,
})

package({
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
  dev = false,
  config = conf.lspsaga,
})

package({
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	config = conf.nvim_cmp,
	dependencies = {
    -- cmp sources
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
		-- snip
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      config = conf.lua_snip,
    },
		-- icon
		{ "onsails/lspkind.nvim", config = conf.lspkind },
		-- nvim-autopairs
		{ "windwp/nvim-autopairs", config = conf.auto_pairs },
	},
})
