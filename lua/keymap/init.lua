local keymap = require("core.keymap")
local nmap, imap, cmap, xmap, vmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.vmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- leaderkey
nmap({ " ", "", opts(noremap) })
xmap({ " ", "", opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  { "<C-n>", cmd("Ex"), opts(noremap) },
  -- add blank space above
  { "<C-Space>", cmd("put! =repeat(nr2char(10), v:count1)|silent ']+"), opts(noremap, silent) },
  { "<M-Space>", cmd("put =repeat(nr2char(10), v:count1)|silent '[-"), opts(noremap, silent) },
  -- recenter view after jump
  { "<C-u>", "<C-u>zz", opts(noremap) },
  { "<C-d>", "<C-d>zz", opts(noremap) },
  -- toggle wrap
  { "<M-z>w", cmd("set wrap!"), opts(noremap, silent) },
})

--[[ xmap({
  {
    "<C-s>",
    function()
      local char_code = vim.fn.getchar()
      local char = vim.fn.nr2char(char_code)
      if char == "\x03" or char == "\x1b" then
        return
      end
      local surrounds = {
        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
        ["<"] = ">",
      }
      local pair_char = surrounds[char] or char
      return "c" .. char .. '<C-r><C-o>"' .. pair_char .. "<ESC><Left>vi" .. char
    end,
    opts(noremap, silent),
  },
}) ]]

imap({
  -- navigation
  { "<C-b>", "<ESC>^i", opts(noremap) },
  { "<C-CR>", "<End>", opts(noremap) },
  { "<C-h>", "<Left>", opts(noremap) },
  { "<C-l>", "<Right>", opts(noremap) },
  { "<C-j>", "<Down>", opts(noremap) },
  { "<C-k>", "<Up>", opts(noremap) },
  -- this is (also) going to get me cancelled
  { "<C-c>", "<Esc>", opts(noremap) },
})

vmap({
  -- litterally move lines
  { "<C-j>", ":m '>+1<CR>gv=gv", opts(noremap) },
  { "<C-k>", ":m '<-2<CR>gv=gv", opts(noremap) },
  -- don't leave visual mode after un.indent
  { "<", "<gv", opts(noremap) },
  { ">", ">gv", opts(noremap) },
})

-- commandline remap
cmap({
  { "<C-h>", "<Left>", opts(noremap) },
  { "<C-l>", "<Right>", opts(noremap) },
})
-- usage of plugins
local zen_mode_enabled = false
nmap({
  -- Zen mode: carpe diem
  {
    "<Leader>zz",
    function()
      require("zen-mode").toggle()
      if zen_mode_enabled then
        zen_mode_enabled = false
      else
        vim.wo.number = false
        vim.wo.rnu = false
        vim.opt.colorcolumn = "0"
        zen_mode_enabled = true
      end
    end,
    opts(noremap),
  },
  -- plugin manager: Lazy.nvim
  { "<Leader>pu", cmd("Lazy update"), opts(noremap, silent) },
  { "<Leader>pi", cmd("Lazy install"), opts(noremap, silent) },
  -- Telescope
  { "<Leader>a", cmd("Telescope app"), opts(noremap, silent) },
  { "<Leader>fa", cmd("Telescope live_grep"), opts(noremap, silent) },
  { "<Leader>fs", cmd("Telescope grep_string"), opts(noremap, silent) },
  { "<Leader>ff", cmd("Telescope find_files find_command=rg,--ignore,--hidden,--files"), opts(noremap, silent) },
  { "<Leader>fg", cmd("Telescope git_files"), opts(noremap, silent) },
  { "<Leader>fw", cmd("Telescope grep_string"), opts(noremap, silent) },
  { "<Leader>fh", cmd("Telescope help_tags"), opts(noremap, silent) },
  { "<Leader>fo", cmd("Telescope oldfiles"), opts(noremap, silent) },
  { "<Leader>gc", cmd("Telescope git_commits"), opts(noremap, silent) },
  { "<Leader>fd", cmd("Telescope dotfiles"), opts(noremap, silent) },
  -- Flybuf
  -- { '<Leader>j', cmd('FlyBuf'), opts(noremap, silent) },
  -- Gitsign
  { "[g", cmd("lua require('gitsigns').prev_hunk()<CR>"), opts(noremap, silent) },
  { "]g", cmd("lua require('gitsigns').next_hunk()<CR>"), opts(noremap, silent) },
  -- Rapid
  { "<Leader>c", cmd("Rapid"), opts(noremap, silent) },
  -- Lspsaga
  { "]e", cmd("Lspsaga diagnostic_jump_prev"), opts(noremap, silent) },
  { "[e", cmd("Lspsaga diagnostic_jump_next"), opts(noremap, silent) },
  { "K", cmd("Lspsaga hover_doc"), opts(noremap, silent) },
  { "ga", cmd("Lspsaga code_action"), opts(noremap, silent) },
  { "gd", cmd("Lspsaga peek_definition"), opts(noremap, silent) },
  { "gp", cmd("Lspsaga goto_definition"), opts(noremap, silent) },
  { "gr", cmd("Lspsaga rename"), opts(noremap, silent) },
  { "gh", cmd("Lspsaga finder"), opts(noremap, silent) },
  { "<Leader>o", cmd("Lspsaga outline"), opts(noremap, silent) },
  { "<Leader>dw", cmd("Lspsaga show_workspace_diagnostics"), opts(noremap, silent) },
  { "<Leader>db", cmd("Lspsaga show_buf_diagnostics"), opts(noremap, silent) },
})
