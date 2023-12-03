local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'c',
      'rust',
      'lua',
      'python',
      'sql',
      'markdown',
      'bash',
      'graphql',
      'diff',
    },
    highlight = {
      enable = true,
      disable = function (_, buf)
        return vim.api.nvim_buf_line_count(buf) > 3000
      end,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
  })
end

return config
