local lspconfig = require("lspconfig")
local _attach = require("modules.completion.backend")._attach

lspconfig.jsonls.setup({
  on_attach = _attach,
})
