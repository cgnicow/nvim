local config = {}

function config.indent_blankline()
  require("ibl").setup({
    indent = { char = "│" },
    exclude = {
      filetypes = {
        "dashboard",
        "log",
        "TelescopePrompt",
      },
      buftypes = {
        "terminal",
        "nofile",
        "prompt",
      },
    },
    scope = { enabled = false },
  })
end

function config.darkrose()
  require("darkrose").setup({
    -- Override colors
    colors = {
      orange = "#F87757",
    },
    -- Override existing or add new highlight groups
    overrides = function(c)
      return {
        Class = { fg = c.magenta },
        ["@variable"] = { fg = c.fg_dark },
      }
    end,
    -- Styles to enable or disable
    styles = {
      bold = true, -- Enable bold highlights for some highlight groups
      italic = true, -- Enable italic highlights for some highlight groups
      underline = true, -- Enable underline highlights for some highlight groups
    },
  })
  vim.cmd([[colorscheme darkrose]])
end

function config.sweet()
  require("sweet-fusion").setup({
    terminal_colors = true,
    transparency = true,
    hl_styles = {
      comments = { italic = true },
      keywords = { italic = false },
    },
    dim_inactive = true,
  })
  -- vim.cmd([[colorscheme sweet-fusion]])
end

function config.forest()
  require("forest").setup({
    style = "serene", -- The theme comes in three styles, `serene`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = true, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
  })
  -- vim.cmd([[colorscheme forest]])
end

function config.transparent()
  -- Optional, you don't have to run setup.
  require("transparent").setup({
    -- table: default groups
    groups = {
      "Normal",
      "NormalNC",
      "Comment",
      "Constant",
      "Special",
      "Identifier",
      "Statement",
      "PreProc",
      "Type",
      "Underlined",
      "Todo",
      "String",
      "Function",
      "Conditional",
      "Repeat",
      "Operator",
      "Structure",
      "LineNr",
      "NonText",
      "SignColumn",
      "CursorLine",
      "CursorLineNr",
      "StatusLine",
      "StatusLineNC",
      "EndOfBuffer",
    },
    -- table: additional groups that should be cleared
    extra_groups = {
      "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      "NvimTreeNormal", -- NvimTree
    },
    -- table: groups you don't want to clear
    exclude_groups = {},
    -- function: code to be executed after highlight groups are cleared
    -- Also the user event "TransparentClear" will be triggered
    on_clear = function() end,
  })
end

function config.gitsigns()
  require("gitsigns").setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┃" },
    },
  })
end

function config.zen()
  require("zen-mode").setup({
    window = {
      width = 80,
      gitsigns = {
        enabled = true,
      },
    },
  })
end

return config
