local config = {}

function config.zephyr()
  vim.cmd('colorscheme industry')
end

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
