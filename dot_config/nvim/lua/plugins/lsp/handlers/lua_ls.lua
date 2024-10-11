return function(name, opts)
  local has_lazydev, lazydev = pcall(require, "lazydev")
  if has_lazydev then
    lazydev.setup({
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    })
  end

  local has_neodev, neodev = pcall(require, "neodev")
  if not has_lazydev and has_neodev then
    neodev.setup()
  end

  require("lspconfig")[name].setup(opts)
end
