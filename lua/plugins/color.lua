return {
  {
    'dracula/vim',
    config = function()
      vim.cmd('colorscheme dracula')

      vim.cmd('highlight cursorline ctermbg=black')
      vim.cmd('highlight! IndentGuidesOdd  ctermbg=233')
      vim.cmd('highlight! IndentGuidesEven ctermbg=234')
      vim.cmd('highlight! jsBlock ctermfg=150')
      vim.cmd('highlight! jsObjectKey ctermfg=139')
      vim.cmd('highlight! Normal ctermbg=NONE')
      vim.cmd('highlight! link @module DraculaCyanItalic')
      vim.cmd('highlight! link @markup.heading.2.elixir DraculaYellowItalic')
      vim.cmd('highlight! link @markup.raw.block @comment.documentation')
      vim.cmd('highlight! link fieldSeparator DraculaPink')
      vim.cmd('highlight! link delimiters DraculaPurple')
      vim.cmd('highlight! link segmentType DraculaGreen')
      vim.cmd('highlight Comment cterm=italic gui=italic ctermfg=8')
      vim.cmd('highlight link elixirFunctionCall DraculaGreen')
      vim.cmd("highlight NormalNC ctermbg=234")

      -- highlight line 80 and 120
      vim.cmd('highlight ColorColumn ctermbg=232')
      vim.cmd('let &colorcolumn="80,".join(range(120,999),",")')
    end
  }
}
