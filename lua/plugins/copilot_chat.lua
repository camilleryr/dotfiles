return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = 'claude-sonnet-4',           -- AI model to use
      temperature = 0.1,           -- Lower = focused, higher = creative
      window = {
        layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
        width = 0.5,              -- 50% of screen width
      },
      auto_insert_mode = true,     -- Enter insert mode when opening
      mappings = {
        show_help = {
          normal = 'g?',  -- Change to your preferred mapping
        },
        jump_to_diff = {
          normal = 'ggj',  -- Change to your preferred mapping
        },
      },
    },
  },
}
