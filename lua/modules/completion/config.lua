local config = {}

-- config server in this function
function config.nvim_lsp()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  lspconfig.clangd.setup({
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--header-insertion=iwyu',
    },
  })

  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
      ['rust_analyzer'] = {
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { 'vim' },
          disable = {
            'missing-fields',
            'no-unknown',
          },
        },
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
            vim.env.HOME .. '/.local/share/nvim/lazy/emmylua-nvim',
          },
          checkThirdParty = false,
        },
        completion = {
          callSnippet = 'Replace',
      },
    },
  },
})


end

function config.nvim_cmp()
  local cmp = require('cmp')

  cmp.setup({
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = require('lspkind').cmp_format({
        mode = 'text_symbol',
        menu = {
          nvim_lsp = '[LSP]',
          luasnip = '[SNIP]',
          path = '[PATH]',
          buffer = '[BUF]',
        },
      }),
    },

    mapping = cmp.mapping.preset.insert({
      -- ['<C-w>'] = cmp.mapping.scroll_docs(-4),
      -- ['<C-x>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ['<TAB>'] = cmp.mapping(function(fallback)
        local ok, luasnip = pcall(require, 'luasnip')
        local luasnip_status = false
        if ok then
          luasnip_status = luasnip.expand_or_jumpable()
        end

        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip_status then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-TAB>'] = cmp.mapping(function(fallback)
        local _, luasnip = pcall(require, 'luasnip')

        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),

    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    sources = {
      { name = 'nvim_lsp', group_index = 2 }, -- nvim-lspconfig
      { name = 'luasnip', group_index = 2 }, -- luasnip
      { name = 'path', group_index = 2 }, -- cmp-path
      { name = 'buffer', group_index = 2, keyword_length = 3 }, -- cmp-buffer
    },

    preselect = cmp.PreselectMode.Item,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.lspsaga()
  require('lspsaga').setup({
    symbol_in_winbar = {
      hide_keyword = true,
      folder_level = 0,
    },
    outline = {
      layout = 'float',
    },
  })
end

function config.auto_pairs()
	local autopairs = require('nvim-autopairs')
	autopairs.setup({
		check_ts = true, -- treesitter integration
		disable_filetype = { 'TelescopePrompt' },
	})
	local ok, cmp = pcall(require, 'cmp')
	if not ok then
		vim.cmd([[packadd nvim-cmp]])
		cmp = require('cmp')
	end
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return config
