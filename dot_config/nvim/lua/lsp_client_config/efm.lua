local function get_config_typescript()
  local prettierd = require("efmls-configs.formatters.prettier_d")
  prettierd.rootMarkers = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.js",
    ".prettierrc.mjs",
    ".prettierrc.cjs",
  }
  prettierd.requireMarker = true

  local eslintd = require("efmls-configs.linters.eslint_d")
  eslintd.rootMarkers = {
    ".eslintrc",
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.json",
  }
  eslintd.requireMarker = true

  local biome = {
    formatCommand = "npx biome format --write --stdin-file-path '${INPUT}'",
    formatStdin = true,
    rootMarkers = { "biome.json", "rome.json" },
    requireMarker = true,
  }

  return { biome, eslintd, prettierd }
end

local function get_config_helm()
  local helm_lint = {
    prefix = "helm",
    lintCommand = "helm lint",
    lintWorkspace = true,
    lintStdin = false,
    lintFormats = {
      "[%tNFO] %f: %m",
      "[%tRROR] %f: %m line %l",
    },
    rootMarkers = { "Chart.yaml" },
    requireMarker = true,
  }
  return { helm_lint }
end

local function get_config_sh()
  local shellharden = require("efmls-configs.formatters.shellharden")
  local shellcheck = require("efmls-configs.linters.shellcheck")

  return { shellcheck, shellharden }
end

local function get_config_markdown()
  local prettierd = require("efmls-configs.formatters.prettier_d")
  return { prettierd }
end

local function get_config_rust()
  local rustfmt = require("efmls-configs.formatters.rustfmt")

  return { rustfmt }
end

local function get_config_lua()
  local stylua = require("efmls-configs.formatters.stylua")

  return { stylua }
end

local function get_config_python()
  local black = require("efmls-configs.formatters.black")
  local flake8 = require("efmls-configs.linters.flake8")

  return { black, flake8 }
end

local function get_config_php()
  local php = require("efmls-configs.linters.php")
  local phpcs = require("efmls-configs.linters.phpcs")
  local phpcbf = require("efmls-configs.formatters.phpcbf")

  return { php, phpcs, phpcbf }
end

local function create_config()
  local opts = {}

  local languages = {
    javascript = get_config_typescript(),
    javascriptreact = get_config_typescript(),
    lua = get_config_lua(),
    php = get_config_php(),
    python = get_config_python(),
    rust = get_config_rust(),
    typescript = get_config_typescript(),
    typescriptreact = get_config_typescript(),
    markdown = get_config_markdown(),
    sh = get_config_sh(),
    bash = get_config_sh(),
    helm = get_config_helm(),
  }

  opts.init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  }

  opts.filetypes = vim.tbl_keys(languages)

  opts.settings = {
    rootMarkers = { ".git/", ".vscode/", ".editorconfig" },
    languages = languages,
  }

  return opts
end

local M = create_config()

return M
