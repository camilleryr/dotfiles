local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local opt = vim.opt
-- opt.winbar = [[%m %t %{%v:lua.require'camiller.lsp'.navic()%}]]
opt.number = true           -- Show line number
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.gdefault=true        --global search by default
opt.lazyredraw=true      --no need to redraw all the time
opt.tabstop=2       --width of tabs
opt.shiftwidth=2    --amount for < and > commands
opt.shiftround=true      --indent to the next multiple of shiftwidth
opt.expandtab=true       --insert spaces instead of tabs
-- opt.nohlsearch=true      --don't highlight searches by default
opt.inccommand='split'  --show substitution while typing
-- opt.path+=**        --include subdirectory globbing in path for :find
-- opt.diffopt+=vertical   --vertical split for diffs


local o = vim.o
o.title=true
o.titlestring=vim.fn.fnamemodify(vim.fn.getcwd(), ':t')

local g = vim.g
g.ruler=true
g.scrolloff=4
g.sidescroll=1
g.sidescrolloff=5
g.list=true
g.mouse="a"
g.mapleader=" "
g.undofile=true
g.undodir="~/.config/nvim/undo/"

local wo = vim.wo
wo.wrap=false

local set = vim.keymap.set

set({'n', 'v'}, ';', ':')
set({'n', 'v'}, ':', ';')

set('n', 'H', '^')
set('n', 'L', '$')

set('n', 'go', 'o<Esc>k')
set('n', 'gO', 'O<Esc>k')

-- remap U to <C-r> for easier redo
-- from http://vimbits.com/bits/356
set('n', 'U', '<C-r>')

-- ---------------
-- Window Movement
-- ---------------
set('n', 'gh', ':wincmd h<CR>', { silent = true })
set('n', 'gj', ':wincmd j<CR>', { silent = true })
set('n', 'gk', ':wincmd k<CR>', { silent = true })
set('n', 'gl', ':wincmd l<CR>', { silent = true })
set('n', 'g=', ':wincmd =<CR>', { silent = true })

-- Make line completion easier.
set('i', '<C-l>', '<C-x><C-l>')

-- Scroll larger amounts with
set({'n', 'v'}, '<C-j>', '15gjzz')
set({'n', 'v'}, '<C-k>', '15gkzz')

-- Toggle spelling mode
set('n', '<leader>sp', ':set spell!<CR>')

-- Quickly switch to last buffer
set('n', '<leader>,', ':e#<CR>')

-- Split window vertically or horizontally *and* switch to the new split!
set('n', '<leader>hs', ':split<Bar>:wincmd j<CR>:wincmd =<CR>', { silent = true })
set('n', '<leader>vs', ':vsplit<Bar>:wincmd l<CR>:wincmd =<CR>', { silent = true })

-- search
set('n', '<leader>r', ':%s/', {})
set('v', '<leader>r', ':s/', {})

set('n', '<leader>mtf', ':execute "SlimeSend1 mix test" . expand("%")<CR>', {})
set('n', '<leader>mtt', ':execute "SlimeSend1 mix test" . expand("%")  . ":" . line(".")<CR>', {})

-- pretty much always want very magic searches
set('n', '/', '/\\v', {})
set('n', '?', '?\v', {})
set('c', '%s/', '%s/\\v', {})
set('c', 's/', 's/\\v', {})

set('t', '<m-h>', '<c-\\><c-n><c-w>h', {})
set('t', '<m-j>', '<c-\\><c-n><c-w>j', {})
set('t', '<m-k>', '<c-\\><c-n><c-w>k', {})
set('t', '<m-l>', '<c-\\><c-n><c-w>l', {})

-- window resizing
set('n', '<M-S-h>', '<C-w><', {})
set('n', '<M-S-j>', '<C-w>+', {})
set('n', '<M-S-k>', '<C-w>-', {})
set('n', '<M-S-l>', '<C-w>>', {})
set('n', '<M-=>', '<c-w>=', { silent = true })

local maximized = 0
local zoom_toggle = function()
  if maximized == 1 then
    vim.cmd('wincmd =')
    maximized = 0
  else
    maximized = 1
    vim.cmd('vertical resize')
    vim.cmd('resize')
  end
end

set('n', "<c-w>'", zoom_toggle, { silent = true })
set('n', "<M-'>", zoom_toggle, { silent = true })

-- open files
set('n', 'gF', ':vertical wincmd f<CR>', {})
set('n', 'gH', ':horizontal wincmd f<CR>', {})


-- mimic D,C (to end of line)
set('n', 'Y', '$', {})

-- use Q to play q macro
set('n', 'Q', '@q', {})
set('x', 'Q', ':normal @q<CR>', {})

-- reselect pasted content:
set('n', 'gV', '`[v`]', {})

-- insert time / date
set('n', '<leader>it', '"=strftime(\"%H:%M\")<CR>P', {})
set('n', '<leader>id', '"=strftime(\"%Y-%m-%d\")<CR>P', {})
set('n', '<leader>iD', '"=strftime(\"%m.%d.%Y\")<CR>P', {})

-- netrw splits
set('n', '<leader>x', ':Vexplore!<CR>:wincmd =<CR>', { silent = true })
set('n', '<leader>X', ':Sexplore<CR>:wincmd =<CR>', { silent = ture })

set('n', '<leader>w', ':w<cr>', {})
set('n', '<leader>q', ':q<cr>', {})
set('n', '<leader>Q', ':bd<cr>', {})

-- search for word under cursor with <leader>*
set('n', '<leader>&', '"myiW :Rg <c-r>m<CR>', {})

-- system clipboard yank
set({'n', 'v'}, '<leader>y', '"+y', {})
set({'n', 'v'}, '<leader>p', '"+p', {})
set({'n', 'v'}, '<leader>P', '"+P', {})

set({'n', 'v'}, '<C-y>', '"*y', {})

-- search for visual selection
-- set('x', '*', ':<C-u>call <SID>VSetSearch("/")<CR>/<C-R>=@/<CR><CR>', {})
-- set('x', '#', ':<C-u>call <SID>VSetSearch("?")<CR>/<C-R>=@/<CR><CR>', {})

-- edit vimrc/zshrc and source vimrc
set('n', 'gev', ':e $MYVIMRC<CR>', {})
set('n', 'gsv', ':so $MYVIMRC<CR>', {})

set('n', 'gez', ':e ~/.zshrc<CR>', {})
set('n', 'gsz', ':so ~/.zshrc<CR>', {})

set('n', '<leader>mcp', ':!mix compile<CR>', {})
set('n', '<leader>mcd', ':!mix credo --strict<CR>', {})
set('n', '<leader>mfp', ':!mix format<CR>', {})
set('n', '<leader>mff', ':!mix format %<CR>', {})
set('n', '<leader>mdz', ':!mix dialyzer<CR>', {})

set('n', '<leader>sdb', ':lua require("camiller.dadbod-db-picker").select_db()<CR>', {})
set('n', 'gg', 'vip:DB<CR>', {})
set('v', 'gg', ':DB<CR>', {})

local wo = vim.wo
wo.number=true

if vim.fn.executable('nvr') then
   vim.fn.setenv("VISUAL", "nvr -cc split --remote-wait +'set bufhidden=wipe'")
end


vim.api.nvim_create_user_command('VTerm', ':vert new<CR> | execute "terminal"', { nargs = "*" })

require("lazy").setup({
    { import = "plugins" },
})

local LSP = require("camiller.lsp")

LSP.setup(
  "lua_ls",
  { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" }, format = { enable = false } } } }
)
LSP.setup("jsonls", {})

require("camiller.autocmds")
