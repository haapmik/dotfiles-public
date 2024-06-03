local M = {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    signs = false,
    --keywords = {
    --  TODO = { icon = "I", color = "info" },
    --  ERROR = { icon = "E", color = "error", alt = { "FIX", "BUG", "ISSUE" } },
    --  WARN = { icon = "W", color = "warning", alt = { "WARNING" } },
    --  HINT = { icon = "H", color = "hint", alt = { "NOTE", "INFO" } },
    --  PERF = { icon = "P", alt = { "OPTIMIZE", "PERFORMANCE" } },
    --  TEST = { icon = "T", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    --},
  },
}

return M
