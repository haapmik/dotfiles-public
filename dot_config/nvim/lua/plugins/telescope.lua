local M = {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "debugloop/telescope-undo.nvim",
    "LinArcX/telescope-env.nvim",
    "smartpde/telescope-recent-files",
    "cljoly/telescope-repo.nvim",
    "someone-stole-my-name/yaml-companion.nvim",
  },
}

function M.config()
  local telescope = require("telescope")
  local theme = "ivy"
  local file_ignore_patterns = {}

  telescope.setup({
    defaults = {
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
      },
      theme = theme,
      file_ignore_patterns = file_ignore_patterns,
      borderchars = { " " }, -- Enable borderless mode
    },
    pickers = {
      find_files = {
        theme = theme,
      },
      live_grep = {
        theme = theme,
      },
      buffers = {
        theme = theme,
      },
      quickfix = {
        theme = theme,
      },
      diagnostics = {
        theme = theme,
      },
      git_status = {
        theme = theme,
      },
      git_branches = {
        theme = theme,
      },
      git_commits = {
        theme = theme,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
        respect_gitignore = false,
      },
      undo = {
        use_delta = true,
      },
      file_browser = {
        theme = theme,
        borderchars = { " " }, -- Enable borderless mode
        hijack_netrw = true,
        grouped = true,
        hidden = true,
        respect_gitignore = false,
      },
      repo = {
        list = {
          search_dirs = {
            "~/git-projects",
          },
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_ivy(),
      },
    },
  })
  telescope.load_extension("fzf")
  telescope.load_extension("file_browser")
  telescope.load_extension("ui-select")
  telescope.load_extension("media_files")
  telescope.load_extension("env")
  telescope.load_extension("repo")
  telescope.load_extension("recent_files")
  telescope.load_extension("yaml_schema")
  telescope.load_extension("undo")
end

return M
