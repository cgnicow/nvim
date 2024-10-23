local config = {}

function config.guard()
  local ft = require("guard.filetype")
  ft("c,cpp"):fmt({
    cmd = "clang-format",
    stdin = true,
    ignore_patterns = { "neovim", "vim" },
  }):lint("clang-tidy")

  ft("lua"):fmt({
    cmd = "stylua",
    args = { "-" },
    stdin = true,
    ignore_patterns = "%w_spec%.lua",
  }):lint("selene")

  ft("asm"):fmt({
    cmd = "asmfmt",
    stdin = true,
  })

  ft("python"):fmt({
    cmd = "black",
    args = { "-" },
    stdin = true,
  }):lint("ruff")

  ft("rust"):fmt("rustfmt")

  require("guard").setup({
    fmt_on_save = true,
    sp_as_default_formatter = true,
  })
end

--  function config.dyninput()
--    local rs = require("dyninput.lang.rust")
--    local ms = require("dyninput.lang.misc")
--    require("dyninput").setup({
--      c = {
--        ["-"] = { "->", ms.is_pointer },
--      },
--      cpp = {
--        [","] = { " <!>", ms.generic_in_cpp },
--        ["-"] = { "->", ms.is_pointer },
--      },
--      rust = {
--        [";"] = {
--          { "::", rs.double_colon },
--          { ": ", rs.single_colon },
--        },
--        ["="] = { " => ", rs.fat_arrow },
--        ["-"] = { " -> ", rs.thin_arrow },
--        ["\\"] = { "|!| {}", rs.closure_fn },
--      },
--      lua = {
--        [";"] = { ":", ms.semicolon_in_lua },
--      },
--    })
--  end

return config
