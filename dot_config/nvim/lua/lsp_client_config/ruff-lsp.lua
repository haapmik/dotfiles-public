local util = require("lspconfig").util

local M = {
  root_dir = util.root_pattern({ "pyproject.toml", "ruff.toml" }),
}

return M
