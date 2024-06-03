local util = require("lspconfig").util

local M = {
  root_dir = util.root_pattern({ "biome.json", "rome.json" }),
}

return M
