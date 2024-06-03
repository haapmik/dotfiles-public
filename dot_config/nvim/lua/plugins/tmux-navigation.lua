return {
  "alexghergh/nvim-tmux-navigation",
  keys = {
    { "<C-w>h", "<cmd>NvimTmuxNavigateLeft<cr>", "Window - Navigate left" },
    { "<C-w>j", "<cmd>NvimTmuxNavigateDown<cr>", "Window - Navigate down" },
    { "<C-w>k", "<cmd>NvimTmuxNavigateUp<cr>", "Window - Navigate up" },
    { "<C-w>l", "<cmd>NvimTmuxNavigateRight<cr>", "Window - Navigate right" },
    { "<C-w>m", "<cmd>WindowsMaximize<cr>", "Window - Maximize" },
    { "<C-w>_", "<cmd>WindowsMaximizeVertically<cr>", "Window - Maximize vertically" },
    { "<C-w>|", "<cmd>WindowsMaximizeHorizontally<cr>", "Window - Maximize horizontally" },
    { "<C-w>=", "<cmd>WindowsEqualize<cr>", "Window - Equalize" },
  },
  opts = {},
}
