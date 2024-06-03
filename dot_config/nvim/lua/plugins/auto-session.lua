local M = {
  "rmagatti/auto-session",
  lazy = true,
  event = "VeryLazy",
}

function M.config()
  require("auto-session").setup({
    auto_save_enabled = true,
    auto_session_use_git_branch = true,
  })

  vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

  local function auto_session_restore()
    -- We need to schedule this action or other actions wont run
    vim.schedule(function()
      require("auto-session").AutoRestoreSession()
    end)
  end

  -- Behaviour with Lazy
  local autocmd = vim.api.nvim_create_autocmd
  local lazy_meny_visible = false
  autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      local lazy_view = require("lazy.view")
      if lazy_view.visible() then
        lazy_meny_visible = true
      else
        auto_session_restore()
      end
    end,
  })
  autocmd("WinClosed", {
    pattern = "*",
    callback = function(ev)
      local lazy_view = require("lazy.view")
      if lazy_view.visible() and lazy_meny_visible then
        if ev.match == tostring(lazy_view.view.win) then
          lazy_meny_visible = false
          auto_session_restore()
        end
      end
    end,
  })
end

return M
