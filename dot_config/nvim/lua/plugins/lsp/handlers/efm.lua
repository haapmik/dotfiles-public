return function(name, opts)
  local default_opts = {
    enabled = true,
    cmd = { "efm-langserver", "-q" },
    init_options = {
      documentFormatting = true,
    }
  }

  require("lspconfig")[name].setup(vim.tbl_deep_extend("force", default_opts, opts))
end
