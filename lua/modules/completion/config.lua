local config = {}

-- config server in this function
function config.nvim_lsp()
  local i = "◉"
  vim.diagnostic.config({ signs = { text = { i, i, i, i } } })
  require("modules.completion.backend")
  require("modules.completion.frontend")

  -- auto kill server when no buffer attach after a while
  local debounce
  vim.api.nvim_create_autocmd("LspDetach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client or #client.attached_buffers > 0 then
        return
      end

      if debounce and debounce:is_active() then
        debounce:stop()
        debounce:close()
        debounce = nil
      end

      if debounce then
        debounce:start(5000, 0, function()
          vim.schedule(function()
            pcall(vim.lsp.stop_client, args.data.client_id, true)
          end)
        end)
      end
    end,
  })
end

function config.lspsaga()
  require("lspsaga").setup({
    symbol_in_winbar = {
      hide_keyword = true,
      folder_level = 0,
    },
    lightbulb = {
      sign = false,
    },
    outline = {
      layout = "float",
    },
  })
end

function config.luasnip()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = "TextChanged, TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "<- choiceNode", "Comment" } },
        },
      },
    },
  })
  require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "./snippets/" },
  })
end

function config.nvim_cmp()
  local cmp = require("cmp")

  cmp.setup({
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = require("lspkind").cmp_format({
        mode = "text_symbol",
        menu = {
          nvim_lsp = "[LSP]",
          luasnip = "[SNIP]",
          path = "[PATH]",
          buffer = "[BUF]",
        },
      }),
    },

    mapping = cmp.mapping.preset.insert({
      -- ["<C-w>"] = cmp.mapping.scroll_docs(-4),
      -- ["<C-x>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ["<TAB>"] = cmp.mapping(function(fallback)
        local ok, luasnip = pcall(require, "luasnip")
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
      end, { "i", "s" }),
      ["<S-TAB>"] = cmp.mapping(function(fallback)
        local _, luasnip = pcall(require, "luasnip")

        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    sources = {
      { name = "nvim_lsp", group_index = 2 }, -- nvim-lspconfig
      { name = "luasnip", group_index = 2 }, -- luasnip
      { name = "path", group_index = 2 }, -- cmp-path
      { name = "buffer", group_index = 2, keyword_length = 3 }, -- cmp-buffer
    },

    preselect = cmp.PreselectMode.Item,
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
  })
end

return config
