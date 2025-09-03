return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'},
      "debugloop/telescope-undo.nvim",
      'nvim-telescope/telescope-github.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    },
    config = function()
      local set = vim.keymap.set
      local actions = require("telescope.actions")
      -- super search
      set('n', '<leader>f', ':Telescope find_files<cr>', {})
      set('n', '<leader>/', ':Telescope grep_string search=', {})
      set('n', '<leader>b', ':Telescope buffers<cr>', {})
      set('n', '<leader>*', ':Telescope grep_string<cr>', {})

      require('telescope').setup{
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key"
            }
          }
        },
        pickers = {
          grep_string = {
            additional_args  = {"--glob", "!**/.git/*", "--glob", "!**/assets/vendor/**/*", "--glob", "!**/priv/static/**/*" },
            use_regex = true
          },
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/assets/vendor/**/*"},
          },
          buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
              },
              ["n"] = {
                ["x"] = actions.delete_buffer,
              },
            }
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
          },
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
          undo = {
            use_delta = true,
            use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
            side_by_side = false,
            vim_diff_opts = { ctxlen = 0 },
            entry_format = "state #$ID, $STAT, $TIME",
            time_format = "",
            mappings = {
              i = {
                -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                -- you want to replicate these defaults and use the following actions. This means
                -- installing as a dependency of telescope in it's `requirements` and loading this
                -- extension from there instead of having the separate plugin definition as outlined
                -- above.
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-cr>"] = require("telescope-undo.actions").restore,
              },
            },
          },
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                            -- the default case_mode is "smart_case"
          },
        }
      }

      local telescope = require("telescope")
      require('telescope').load_extension('gh')
      require('telescope').load_extension('fzf')
      require("telescope").load_extension('live_grep_args')
      require("telescope").load_extension('undo')

      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup {
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
          }
        }
      }
    end
  }
}
