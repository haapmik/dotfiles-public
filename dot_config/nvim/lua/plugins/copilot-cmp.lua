return {
  "zbirenbaum/copilot-cmp",
  event = { "InsertEnter", "LspAttach" },
  config = function()
    require("copilot_cmp").setup()

    local copilot_status, copilot = pcall(require, "copilot")
    if copilot_status then
      copilot.setup({
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = false,
        },
        filetypes = {
          markdown = true,
          gitcommit = true,
          yaml = true,
        },
      })
    end
  end,
}
