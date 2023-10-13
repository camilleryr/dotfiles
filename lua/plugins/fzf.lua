local fzf = function(func)
  return function(...)
    return require("fzf-lua")[func](...)
  end
end

return {
    {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    -- optional for icon support
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local actions = require("fzf-lua.actions")
      require("fzf-lua").setup {
        winopts = {
          height = 0.6, -- window height
          width = 0.9,
          row = 0, -- window row position (0=top, 1=bottom)
        },
        actions = {
          files = {
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-x"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["alt-q"] = actions.file_sel_to_qf,
            ["alt-l"] = actions.file_sel_to_ll,
          },
        },
        lsp = {
          symbols = {
            symbol_icons = {
              File = "󰈙",
              Module = "",
              Namespace = "󰦮",
              Package = "",
              Class = "󰆧",
              Method = "󰊕",
              Property = "",
              Field = "",
              Constructor = "",
              Enum = "",
              Interface = "",
              Function = "󰊕",
              Variable = "󰀫",
              Constant = "󰏿",
              String = "",
              Number = "󰎠",
              Boolean = "󰨙",
              Array = "󱡠",
              Object = "",
              Key = "󰌋",
              Null = "󰟢",
              EnumMember = "",
              Struct = "󰆼",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰗴",
            },
          },
        },
      }
    end,
    keys = {
      { "<c-p>", fzf("files"), desc = "Find files" },
      { "<space>p", fzf("git_status"), desc = "Find of changes files" },
      {
        "<space>vp",
        function()
          fzf("files") { cwd = vim.fn.expand("~/.local/share/nvim/lazy") }
        end,
        desc = "Find files of vim plugins",
      },
      -- { "<space>df", "<cmd>Files ~/src/<cr>", desc = "Find files in all projects" },
      -- { "gl", fzf("blines"), desc = "FZF Buffer Lines" },
      { "<leader>a", fzf("live_grep"), desc = "Search in project" },
      -- { "<space>a", ":GlobalProjectSearch<cr>", desc = "Search in all projects" },
    },
  },
}
