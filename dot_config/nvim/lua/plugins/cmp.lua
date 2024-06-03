local M = {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "neovim/nvim-lspconfig",
    "octaltree/cmp-look",
    "petertriho/cmp-git",
    "zbirenbaum/copilot-cmp",
    {
      "saadparwaiz1/cmp_luasnip",
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          build = "make install_jsregexp",
        },
      },
    },
    {
      "onsails/lspkind.nvim",
      config = function()
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
      end,
    },
    "windwp/nvim-autopairs",
  },
}

local has_words_before = function()
  if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

function M.config()
  local cmp = require("cmp")

  -- Default completion logic
  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    formatting = {
      format = require("lspkind").cmp_format({
        mode = "symbol_text",
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          vsnip = "[VSnippet]",
          path = "[Path]",
          look = "[Look]",
          luasnip = "[LuaSnip]",
          git = "[Git]",
          cmd = "[Cmd]",
          cmd_history = "[CmdHistory]",
          nvim_lua = "[NvimLua]",
          copilot = "[Copilot]",
        },
      }),
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,

        -- Below is the default comparitor list and order
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-f>"] = cmp.mapping.scroll_docs(-4),
      ["<C-b>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      --["<Tab>"] = vim.schedule_wrap(function(fallback)
      --  if cmp.visible() and has_words_before() then
      --    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      --  else
      --    fallback()
      --  end
      --end),
    }),
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    -- Default snippet sources for common files
    sources = {
      { name = "nvim_lsp", group_index = 2 },
      { name = "nvim_lsp_signature_help", group_index = 2 },
      { name = "copilot", group_index = 2, keyword_length = 0 },
      { name = "luasnip", group_index = 2 },
      { name = "path", group_index = 2 },
      { name = "nvim_lua", group_index = 2 },
      { name = "buffer", group_index = 2 },
      { name = "git", group_index = 3 },
      {
        name = "look",
        max_item_count = 10,
        keyword_length = 3,
        option = { convert_case = true, loud = true },
        group_index = 3,
      },
    },
  })

  -- CMD specific comletion
  cmp.setup.cmdline(":", {
    performance = {
      max_view_entries = 15,
    },
    sources = {
      { name = "path" },
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline("/", {
    performance = {
      max_view_entries = 15,
    },
    sources = {
      { name = "buffer" },
      { name = "cmdline_history" },
      { name = "nvim_lsp_document_symbol" },
    },
  })
  -- Git specific completion
  cmp.setup.filetype("gitcommit", {
    sources = {
      { name = "git" },
      { name = "buffer" },
    },
  })

  -- Add autopairs support
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
