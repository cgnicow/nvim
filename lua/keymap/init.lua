local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, vmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  { '<C-n>', cmd('Ex'), opts(noremap) },
  -- remove trailing white space
  { '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
})

nmap({
  { 'J', ':m .+1<CR>==gi', opts(noremap) },
  { 'K', ':m .-2<CR>==gi', opts(noremap) },
})

imap({
  -- insert mode
  { '<C-h>', '<Bs>', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
  { '<C-j>', '<Esc>:m .+1<CR>==gi', opts(noremap) },
  { '<C-k>', '<Esc>:m .-2<CR>==gi', opts(noremap) },
})

-- commandline remap
cmap({ '<C-b>', '<Left>', opts(noremap) })
-- usage of plugins
nmap({
  -- plugin manager: Lazy.nvim
  { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
  { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
  -- dashboard
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>b', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
})
