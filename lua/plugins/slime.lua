return {
  {
    'jpalardy/vim-slime',
    init = function()
      vim.g.slime_target="neovim"
    end,
    config = function()
      vim.cmd([[
        function SlimeOverride_EscapeText_elixir(text)
          return substitute(a:text, '\n[\^$]\@=', ' \\\n', 'g')
        endfunction
      ]])

      vim.keymap.set('n', '<leader>mtf', ':execute "SlimeSend1 mix test " . expand("%")<CR>')
      vim.keymap.set('n', '<leader>mtt', ':execute "SlimeSend1 mix test " . expand("%") . ":" . line(".")<CR>')
    end
  }
}
