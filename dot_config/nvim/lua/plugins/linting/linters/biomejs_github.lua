---@return lint.Linter
local function get_linter()
  local has_lint_parser, lint_parser = pcall(require, "lint.parser")

  if not has_lint_parser then return {} end

  local lint_cmd = function()
    local binary_name = "biome"
    local fs = require("utils.fs")
    return fs.get_executable(binary_name)
  end

  local pattern = "::(%w+) title=(.*),file=(.*),line=(%d+),endLine=(%d+),col=(%d+),endColumn=(%d+)::(.*)"
  local pattern_group = {
    "severity",
    "code",
    "file",
    "lnum",
    "end_lnum",
    "col",
    "end_col",
    "message"
  }
  local severity_map = {
    error = vim.diagnostic.severity.ERROR,
    warning = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
  }

  return {
    name = "biomejs",
    cmd = lint_cmd(),
    args = { "lint", "--reporter=github", "--colors=off" },
    stdin = false,
    ignore_exitcode = true,
    stream = "both",
    parser = lint_parser.from_pattern(
      pattern,
      pattern_group,
      severity_map,
      {
        source = "biomejs",
      }
    ),
  }
end

return get_linter()
