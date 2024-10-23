local M = {}
local lspconfig = require("lspconfig")

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

function M._attach(client, _)
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
  client.server_capabilities.semanticTokensProvider = nil
  local orignal = vim.notify
  local mynotify = function(msg, level, opts)
    if msg == "No code actions available" or msg:find("overly") then
      return
    end
    orignal(msg, level, opts)
  end
  vim.notify = mynotify

  if client.name == "ruff_lsp" then
    client.server_capabilities.hoverProvider = false
  end
end

lspconfig.lua_ls.setup({
  on_attach = M._attach,
  capabilities = M.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        unusedLocalExclude = { "_*" },
        globals = { "vim" },
        disable = {
          "luadoc-miss-see-name",
          "undefined-field",
        },
      },
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          vim.env.HOME .. "/.local/share/nvim/lazy/emmylua-nvim",
        },
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

lspconfig.clangd.setup({
  on_attach = M._attach,
  capabilities = M.capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
})

--[[ lspconfig.ccls.setup({
  on_attach = M._attach,
  capabilities = M.capabilities,
  init_options = {
    cache = {
      directory = ".ccls-cache",
    },
  },
}) ]]

lspconfig.rust_analyzer.setup({
  on_attach = M._attach,
  capabilities = M.capabilities,
  settings = {
    ["rust_analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
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

lspconfig.zls.setup({
  on_attach = M._attach,
  capabilities = M.capabilities,
  cmd = { "zls" },
  filetypes = { "zig", "zon" },
  -- root_dir = util.root_pattern("zls.json", "build.zig", ".git"),
})

lspconfig.asm_lsp.setup({
  on_attach = M._attach,
  capabilities = M.capabilities,
  cmd = {
    "asm-lsp",
  },
  filetypes = {
    "asm",
    "nasm",
    "s",
    "S",
  },
})

lspconfig.pyright.setup({
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
})

lspconfig.ruff_lsp.setup({
  on_attach = M._attach,
  capabilities = M.capabilities,
  init_options = {
    settings = {
      args = {},
    },
  },
})

local servers = {
  "zls",
  "bashls",
  "asm_lsp",
  "pyright",
  "ruff_lsp",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = M._attach,
    capabilities = M.capabilities,
  })
end

vim.lsp.handlers["workspace/diagnostics/refresh"] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
  return true
end

return M
