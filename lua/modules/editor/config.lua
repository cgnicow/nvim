local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command("set foldmethod=expr")
  vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "rust",
      "lua",
      "python",
      "bash",
      "glsl",
    },
    auto_install = true,
    ignore_install = { "javascript" },
    highlight = {
      enable = true,
      disable = function(_, buf)
        return vim.api.nvim_buf_line_count(buf) > 3000
      end,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  })
end

function config.telescope()
  require("telescope").setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      layout_config = {
        horizontal = { prompt_position = "top", results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = "ascending",
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require("telescope").load_extension("fzy_native")
  require("telescope").load_extension("dotfiles")
  require("telescope").load_extension("app")
end

function config.highlight()
  require("local-highlight").setup({
    disable_file_types = { "tex" },
    hlgroup = "Search",
    cw_hlgroup = nil,
    -- Whether to display highlights in INSERT mode or not
    insert_mode = false,
    min_match_len = 1,
    max_match_len = math.huge,
    highlight_single_match = true,
  })
end

-- function config.flash_nvim()
--   require("flash").setup({
--     labels = "asdfghjklqwertyuiopzxcvbnm",
--     search = {
--       multi_window = true,
--       forward = true,
--       wrap = true,
--       mode = "exact",
--       incremental = false,
--       exclude = {
--         "notify",
--         "cmp_menu",
--         "noice",
--         "flash_prompt",
--         function(win)
--           return not vim.api.nvim_win_get_config(win).focusable
--         end,
--       },
--       trigger = "",
--       max_length = false,
--     },
--     jump = {
--       jumplist = true,
--       pos = "start",
--       history = false,
--       register = false,
--       nohlsearch = false,
--       autojump = false,
--       inclusive = nil,
--       offset = nil,
--     },
--     label = {
--       uppercase = true,
--       exclude = "",
--       current = true,
--       after = true,
--       before = false,
--       style = "overlay",
--       reuse = "lowercase",
--       distance = true,
--       min_pattern_length = 0,
--       rainbow = {
--         enabled = false,
--         shade = 5,
--       },
--       format = function(opts)
--         return { { opts.match.label, opts.hl_group } }
--       end,
--     },
--     highlight = {
--       backdrop = true,
--       matches = true,
--       priority = 5000,
--       groups = {
--         match = "FlashMatch",
--         current = "FlashCurrent",
--         backdrop = "FlashBackdrop",
--         label = "FlashLabel",
--       },
--     },
--     action = nil,
--     pattern = "",
--     continue = false,
--     config = nil,
--     modes = {
--       search = {
--         enabled = true,
--         highlight = { backdrop = false },
--         jump = { history = true, register = true, nohlsearch = true },
--         search = {
--         },
--       },
--       char = {
--         enabled = true,
--         config = function(opts)
--           opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")
--
--           opts.jump_labels = opts.jump_labels
--             and vim.v.count == 0
--             and vim.fn.reg_executing() == ""
--             and vim.fn.reg_recording() == ""
--
--         end,
--         autohide = false,
--         jump_labels = true,
--         multi_line = true,
--         label = { exclude = "hjkliardc" },
--         keys = { "f", "F", "t", "T", ";", "," },
--         char_actions = function(motion)
--           return {
--             [";"] = "next",
--             [","] = "prev",
--             [motion:lower()] = "next",
--             [motion:upper()] = "prev",
--           }
--         end,
--         search = { wrap = false },
--         highlight = { backdrop = true },
--         jump = { register = false },
--       },
--       treesitter = {
--         labels = "abcdefghijklmnopqrstuvwxyz",
--         jump = { pos = "range" },
--         search = { incremental = false },
--         label = { before = true, after = true, style = "inline" },
--         highlight = {
--           backdrop = false,
--           matches = false,
--         },
--       },
--       treesitter_search = {
--         jump = { pos = "range" },
--         search = { multi_window = true, wrap = true, incremental = false },
--         remote_op = { restore = true },
--         label = { before = true, after = true, style = "inline" },
--       },
--       remote = {
--         remote_op = { restore = true, motion = true },
--       },
--     },
--     prompt = {
--       enabled = true,
--       prefix = { { "⚡", "FlashPromptIcon" } },
--       win_config = {
--         relative = "editor",
--         width = 1,
--         height = 1,
--         row = -1,
--         col = 0,
--         zindex = 1000,
--       },
--     },
--     remote_op = {
--       restore = false,
--       motion = false,
--     },
--
--   })
-- end

return config
