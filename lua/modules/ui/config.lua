local config = {}

vim.cmd('colorscheme industry')

function config.indent_blankline()
  require('ibl').setup({
    indent = { char = '│' },
    exclude = {
      filetypes = {
        'dashboard',
        'log',
        'TelescopePrompt',
      },
      buftypes = {
        'terminal',
        'nofile',
        'prompt',
      },
    },
    scope = { enabled = false },
  })
end

return config
