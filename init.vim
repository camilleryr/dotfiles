scriptencoding utf-8
" install plug if not found {{{1
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
    autocmd VimEnter * PlugInstall
  augroup end
endif

" plugins {{{1
call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" autocomplete and snippets
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'onsails/lspkind-nvim'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'simnalamburt/vim-mundo'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fireplace'

Plug 'sheerun/vim-polyglot'
Plug 'exu/pgsql.vim'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/SyntaxRange'


Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'      "ae/ie for entire file
Plug 'kana/vim-textobj-indent'      "ai/ii for indent block
Plug 'kana/vim-textobj-line'        "al/il for line
Plug 'sgur/vim-textobj-parameter'   "a,/i, for argument/parameter
Plug 'aoswalt/vim-textobj-elixir'   "aE/iE for Elixir blocks as remapped
Plug 'Julian/vim-textobj-variable-segment'    "av/iv for variable part
Plug 'Chun-Yang/vim-textobj-chunk'  "ac/ic for json-ish chunk
Plug 'whatyouhide/vim-textobj-xmlattr'  "ax/ix for xml attribute

Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'vim-scripts/dbext.vim'
Plug 'chrisbra/csv.vim'
Plug 'junegunn/vim-peekaboo'

Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'guns/xterm-color-table.vim'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'ryanoasis/vim-devicons'

Plug 'machakann/vim-highlightedyank'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-dadbod'

Plug 'dracula/vim'
Plug 'markvincze/panda-vim'
Plug 'w0ng/vim-hybrid'

Plug 'ryanoasis/vim-devicons'
Plug 'rizzatti/dash.vim'
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'diepm/vim-rest-console'

Plug 'wesQ3/vim-windowswap'

Plug 'neoclide/jsonc.vim'

Plug 'vim-test/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'elixir-editors/vim-elixir'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'lambdalisue/vim-manpager'
Plug 'gitrust/vim-hl7'

Plug 'jpalardy/vim-slime'
Plug 'wellle/targets.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

" vim settings {{{1
set noswapfile
set number          "line numbers
set norelativenumber          "line numbers
" set cursorline      "highlight cursorline
set ruler           "show line/column
set scrolloff=4     "keep more lines on screen while scrolling
set sidescroll=1    "horizontal scroll amount
set sidescrolloff=5 "horizontal scrolloff
set list            "enable invisible characters
set nowrap          "do not wrap lines by default
set mouse=a         "use mouse in all modes

" QoL tweaks
set tabstop=2       "width of tabs
set shiftwidth=2    "amount for < and > commands
set shiftround      "indent to the next multiple of shiftwidth
set expandtab       "insert spaces instead of tabs

" set hidden          "allow hiding a buffer instead of requring save
set splitbelow      "default horizontal split to lower
set splitright      "default vertical split to right

set ignorecase      "ignore caps when searching
set smartcase       "unless a capital is used
set infercase       "smart auto-completion casing
set wildignorecase  "ignore case on files and directories
set gdefault        "global search by default
set lazyredraw      "no need to redraw all the time
set nohlsearch      "don't highlight searches by default
set inccommand=nosplit  "show substitution while typing
set path+=**        "include subdirectory globbing in path for :find
set diffopt+=vertical   "vertical split for diffs

set noshowmode      "do not show mode since using lightline

" characters for horizontal scrolled text
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿
set tw=79

set completeopt=longest,menuone

let g:mapleader = ' ' "remapped comma to leader

if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undofile
set undodir=~/.config/nvim/undo/

" override $VISUAL to use nvr inside neovim
if executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" ---------------
" Regular Mappings
" ---------------

" Use ; for : in normal and visual mode, less keystrokes
nnoremap ; :
vnoremap ; :

noremap ; :
noremap : ;

" Yank entire buffer with gy
nnoremap gy :0,$ y<cr>

" Just to beginning and end of lines easier. From http://vimbits.com/bits/16
noremap H ^
noremap L $

" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" remap U to <C-r> for easier redo
" from http://vimbits.com/bits/356
nnoremap U <C-r>

" ---------------
" Window Movement
" ---------------
nnoremap <silent> gh :wincmd h<CR>
nnoremap <silent> <m-h> :wincmd h<CR>
nnoremap <silent> gj :wincmd j<CR>
nnoremap <silent> <m-j> :wincmd j<CR>
nnoremap <silent> gk :wincmd k<CR>
nnoremap <silent> <m-k> :wincmd k<CR>
nnoremap <silent> gl :wincmd l<CR>
nnoremap <silent> <m-l> :wincmd l<CR>

"   4 Window Splits
"
"   -----------------
"   g1 | g2 | g3 | g4
"   -----------------
nnoremap <silent> g1 :WriteBufferIfNecessary<CR>:wincmd t<CR>
nnoremap <silent> g2 :WriteBufferIfNecessary<CR>:wincmd t<bar>:wincmd l<CR>
nnoremap <silent> g3 :WriteBufferIfNecessary<CR>:wincmd t<bar>:wincmd l<bar>
      \:wincmd l<CR>
nnoremap <silent> g4 :WriteBufferIfNecessary<CR>:wincmd b<CR>

" Equal Size Windows
nnoremap <silent> g= :wincmd =<CR>

function! WriteBufferIfNecessary()
  if &modified && !&readonly
    :write
  endif
endfunction
command! WriteBufferIfNecessary call WriteBufferIfNecessary()

" ---------------
" Modifer Mappings
" ---------------

" Make line completion easier.
inoremap <C-l> <C-x><C-l>

" Scroll larger amounts with
nnoremap <C-j> 15gjzz
nnoremap <C-k> 15gkzz
vnoremap <C-j> 15gjzz
vnoremap <C-k> 15gkzz

" ---------------
" Insert Mode Mappings
" ---------------

" ---------------
" Leader Mappings
" ---------------

" Toggle spelling mode
nnoremap <silent> <leader>sp :set spell!<CR>

" Quickly switch to last buffer
nnoremap <leader>, :e#<CR>

" Split window vertically or horizontally *and* switch to the new split!
nnoremap <silent> <leader>hs :split<Bar>:wincmd j<CR>:wincmd =<CR>
nnoremap <silent> <leader>vs :vsplit<Bar>:wincmd l<CR>:wincmd =<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <leader>r :%s/
vnoremap <leader>r :s/

vnoremap // y/<C-R>"<CR>

if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

let g:slime_target = "neovim"

" plugin settings {{{1
let g:netrw_altfile = 1   "allow <c-6> to go to the previously edited file
let g:netrw_preview = 1   "open preview window in a vertical split
let g:netrw_localrmdir="rm -r"  "allow deleting non-empty directories

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1

let g:highlightedyank_highlight_duration = 350

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('%')} = "%{\r}"

let g:vim_textobj_elixir_mapping = 'E'

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:quickrun_config = {}
let g:quickrun_config['javascript.jsx'] = { 'type': 'javascript' }
let g:quickrun_config['sh'] = { 'type': 'bash' }

let g:sql_type_default = 'sqlserver'

" autocommands {{{1
augroup whitespace
  " automatically strip trailiing whitespace on save
  autocmd BufWritePre * StripWhitespace
augroup end

augroup ft_match_words
  " add do/end as jumps for %
  autocmd FileType elixir let b:match_words = '\<do\>:\<end\>'
augroup end

let s:hl7_expanded=0
function! HL7Toggle()
  if s:hl7_expanded
    call ContractHL7()
    let s:hl7_expanded=0
  else
    call ExpandHL7()
    let s:hl7_expanded=1
  endif
endfunction

fun! ExpandHL7()
  " Save cursor position
  let l:save = winsaveview()
  " Remove trailing whitespace
  %s/\v(|)/\r/e
  %s///e
  " Move cursor to original position
  call winrestview(l:save)
endfun

fun! ContractHL7()
  " Save cursor position
  let l:save = winsaveview()
  " Remove trailing whitespace
  g/^$/d
  %s/\v\n/\/e
  %s/\vMSH/MSH/e
  %s/\v^MSH/MSH/e
  %s/\vMSH/\\MSH/e
  %s/\v$/\\
  " Move cursor to original position
  call winrestview(l:save)
endfun

augroup hl7
  " add do/end as jumps for %
  " autocmd FileType hl7 nmap <buffer> <C-h>e :%s/\v(|)/\r<CR>
  " autocmd FileType hl7 nnoremap <C-h>e echom "called"
  autocmd FileType hl7 nnoremap <silent> <C-h><C-h> :call HL7Toggle()<CR>
augroup end

nnoremap <leader>mtwf :execute "SlimeSend1 mix test.watch " . expand('%')<CR>
nnoremap <leader>mtwt :execute "SlimeSend1 mix test.watch " . expand('%') . ":" . line(".")<CR>

highlight cursorline ctermbg=black

fun! CromaHighlighting()
    syn match cromaDefine '\<defun\>\(:\)\@!' nextgroup=elixirFunctionDeclaration skipwhite skipnl
    syn match cromaPrivateDefine '\<defunp\>\(:\)\@!' nextgroup=elixirPrivateFunctionDeclaration skipwhite skipnl
    hi link cromaDefine DraculaPink
    hi link cromaPrivateDefine DraculaPink
endfu

" use pgsql syntax inside elixir non-doc string blocks
augroup elixirAdditionalSyntax
  autocmd!
  autocmd FileType elixir call SyntaxRange#Include('\s\{2,\}\"\"\"', '\"\"\"', 'pgsql', 'NonText')
  autocmd FileType elixir call SyntaxRange#Include('calc(\"\"\"', '\"\"\"', 'javascript', 'Text')
  autocmd FileType elixir call CromaHighlighting()
augroup end

augroup pum
  " auto-close preview pane
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

augroup term_settings
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
  autocmd TermOpen * startinsert

  autocmd TermOpen * nnoremap <buffer> gx :call Open(expand('<cfile>'))<CR>
  autocmd TermOpen * vnoremap <buffer> gx "xy \| :call Open(@x)<CR>
augroup end

function! Open(url)
  silent execute '!open ' . shellescape(a:url, 1)
  redraw!
endfunction

" colors {{{1
colorscheme dracula

highlight! IndentGuidesOdd  ctermbg=233
highlight! IndentGuidesEven ctermbg=234

highlight! jsBlock ctermfg=150
highlight! jsObjectKey ctermfg=139
highlight! Normal ctermbg=NONE

highlight! link fieldSeparator DraculaPink
highlight! link delimiters DraculaPurple
highlight! link segmentType DraculaGreen

" highlight! link TermCursor Cursor
highlight! TermCursorNC ctermbg=0 ctermfg=15

highlight Pmenu ctermbg=darkgray ctermfg=white
highlight PmenuSel ctermbg=lightgray ctermfg=black
highlight ErrorMsg guifg=black
highlight link Constant DraculaPurple
highlight link elixirArguments DraculaOrange

highlight Comment cterm=italic gui=italic ctermfg=8

highlight link elixirFunctionCall DraculaGreen

" highlight line 80 and 120+
highlight ColorColumn ctermbg=232
let &colorcolumn="80,".join(range(120,999),",")

 "blacklist some files for line length markers
autocmd FileType markdown let &colorcolumn=""

" lighten non-active windows
highlight NormalNC ctermbg=234

augroup elixir_colors
  autocmd FileType elixir highlight! Identifier ctermfg=88
augroup end

augroup dadbod_output_syntax
  autocmd BufRead *.dbout set syntax=sql
augroup end

" pretty much always want very magic searches
nnoremap / /\v
nnoremap ? ?\v
cnoremap %s/ %s/\v
cnoremap s/ s/\v

" move cursor into wrapped lines
nnoremap k gk
nnoremap j gj

" terminal keybindings
au TermOpen * tnoremap <buffer> <Esc><Esc> <c-\><c-n>
" au FileType fzf tunmap <buffer> <Esc><Esc>
tnoremap <m-h> <c-\><c-n><c-w>h
tnoremap <m-j> <c-\><c-n><c-w>j
tnoremap <m-k> <c-\><c-n><c-w>k
tnoremap <m-l> <c-\><c-n><c-w>l

tnoremap <m-r><m-c> <c-\><c-n>:!$WATERPARK_SRC_DIR/run_cluster.sh<cr>
nnoremap <m-r><m-c> :!$WATERPARK_SRC_DIR/run_cluster.sh<cr>

" tab switching like tmux
nnoremap <leader><m-h> :tabprev<cr>
nnoremap <leader><m-l> :tabnext<cr>

" window resizing
nnoremap <M-S-h> <C-w><
nnoremap <M-S-j> <C-w>+
nnoremap <M-S-k> <C-w>-
nnoremap <M-S-l> <C-w>>
nnoremap <silent> <M-=> <c-w>=
nnoremap <silent> <c-w>' :call ZoomToggle()<cr>
nnoremap <silent> <c-w>z :call MaximizeWindow()<cr>
nnoremap <silent> <M-'> :call ZoomToggle()<cr>
nnoremap <silent> <M-z> :call MaximizeWindow()<cr>

" open file to side
nnoremap gF :vertical wincmd f<CR>

" mimic D,C (to end of line)
nnoremap Y y$

" use Q to play q macro
nnoremap Q @q

" allow range commands from searches - ex:  /foo$m
cnoremap $t <CR>:t''<CR>
cnoremap $m <CR>:m''<CR>
cnoremap $d <CR>:d<CR>``

" reselect pasted content:
noremap gV `[v`]

" insert time / date
nnoremap <leader>it "=strftime("%H:%M")<CR>P
nnoremap <leader>id "=strftime("%Y-%m-%d")<CR>P
nnoremap <leader>iD "=strftime("%m.%d.%Y")<CR>P

" netrw splits
noremap <silent> <leader>x :Vexplore!<CR>:wincmd =<CR>
noremap <silent> <leader>X :Sexplore<CR>:wincmd =<CR>

" use sudo for file if forgot to when opened
nnoremap <leader>sw :w !sudo tee % >/dev/null<cr>

" super search
nnoremap <leader>f :Telescope find_file<cr>
nnoremap <leader>/ :Telescope grep_string search=

" buffer management
nnoremap <leader>b :Telescope buffers<cr>
nnoremap <c-up> :ls<cr>:b
nnoremap <c-right> :bn<cr>
nnoremap <c-left> :bp<cr>
nnoremap <c-down> :bn \| bd #<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :bd<cr>

" search for word under cursor with <leader>*
nnoremap <leader>* :Telescope grep_string<cr>
nnoremap <leader>& "myiW :Rg <c-r>m<CR>

" system clipboard yank
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P

nnoremap <C-y> "*y
vnoremap <C-y> "*y

" toggle markdonw
nnoremap <leader>mdp :MarkdownPreviewToggle<cr>

" put searches in middle of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
xmap n nzz
xmap N Nzz
xmap * *zz
xmap # #zz
nmap g* g*zz
nmap g# g#zz

" nnoremap <leader>d :Dispatch<cr>
" vnoremap <leader>d :<c-u>execute ':Dispatch ' . substitute(b:dispatch, '%', shellescape(join(getline(line("'<"), line("'>")), "\n"), "\n"), "")<cr>

" search for visual selection
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>/<C-R>=@/<CR><CR>

" pane toggles
nnoremap <F5> :MundoToggle<CR>
nnoremap <F8>  :TagbarToggle<CR>

" edit vimrc/zshrc and source vimrc
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>

nnoremap gez :e ~/.zshrc<CR>
nnoremap gsz :so ~/.zshrc<CR>

" save session
nnoremap <leader>s :mksession<CR>

" term splits like tmux
noremap <leader>\ :VTerm<CR>
nnoremap <leader>- :STerm<CR>
nnoremap <leader>\| :VTermRepo<CR>
nnoremap <leader>_ :STermRepo<CR>

" inside template tags
onoremap <silent> iT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?\\zs.\rv/\\v.\\ze[%}][>}]\r"<cr>
vnoremap <silent> iT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?\\zs.\rv/\\v.\\ze[%}][>}]\r"<cr>
onoremap <silent> aT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?.\rv/\\v[%}][>}]/e\r"<cr>
vnoremap <silent> aT :<c-u>execute "silent normal! ?\\v[{<][{%]\\=\\?.\rv/\\v[%}][>}]/e\r"<cr>

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" TODO(adam): use Dispatch to default these?
autocmd FileType sql nnoremap <buffer> gss :.DB<cr>
autocmd FileType sql nmap <buffer> <expr> gs db#op_exec()
autocmd FileType sql vmap <buffer> <expr> gs db#op_exec()

autocmd FileType mysql nnoremap <buffer> gss :.DB<cr>
autocmd FileType mysql nmap <buffer> <expr> gs db#op_exec()
autocmd FileType mysql vmap <buffer> <expr> gs db#op_exec()

nnoremap <silent> <leader>S :ToggleSqlScratch<cr>

nnoremap <silent> <leader>Rp :ReadPreview<cr><Paste>

" run 'q' macro on selection
xnoremap Q :normal @q<CR>

" commands {{{1
" close all other buffers
command! BufOnly :%bd|e#

command! BufCleanup :call BufCleanup()
command! SynStack :call SynStack()

" open a terminal in a different view while setting bufhidden to hide to keep alive
command! -nargs=* VTerm :vert new
  \ | execute 'terminal' <args>
command! -nargs=* VTermRepo :vsp
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <args>
command! -nargs=* STerm :sp
  \ | execute 'terminal' <args>
command! -nargs=* STermRepo :sp
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <args>
command! -nargs=* TTerm :tabnew
  \ | execute 'terminal' <args>
command! -nargs=* TTermRepo :tabedit
  \ fnameescape(FugitiveWorkTree())
  \ | execute 'lcd' fnameescape(FugitiveWorkTree())
  \ | execute 'terminal' <args>

" fugitive bindings
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gS :Telescope git_stash<cr>
nnoremap <leader>gc :Telescope git_bcommits<cr>
nnoremap <leader>gC :Telescope git_commits<cr>
nnoremap <leader>gb :Telescope git_branches<cr>


nnoremap <leader>tn :w<CR>:TestNearest<CR>
nnoremap <leader>tf :w<CR>:TestFile<CR>
nnoremap <leader>ts :w<CR>:TestSuite<CR>

nnoremap <leader>mcp :!mix compile<CR>
nnoremap <leader>mcd :!mix credo --strict<CR>
nnoremap <leader>mf :!mix format<CR>
nnoremap <leader>mdz :!mix dialyzer<CR>

nnoremap <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

command! -range FormatJSON :<line1>,<line2>call FormatJSON()

command! -nargs=* Gpc execute('Gpush --set-upstream origin '.FugitiveHead().' '.<q-args>)

command! ToggleSqlScratch :call ToggleSqlScratch(<q-mods>)

command! ReadPreview call ReadPreview()

" air-line
let g:airline_powerline_fonts = 1

" quickfix-reflector
let g:qf_modifiable = 1
let g:qf_join_changes = 1
let g:qf_write_changes = 1

" functions {{{1
function! MaximizeWindow()
  vertical resize
  resize
endfunction

let s:maximized=0
function! ZoomToggle()
  if s:maximized
    wincmd =
    let s:maximized=0
  else
    call MaximizeWindow()
    let s:maximized=1
  endif
endfunction

" use :NN {filetype} on a visual selection to open a new buffer with
" the filetype set - when the buffer is saved it will save the changes
" to the original file
command! -nargs=* -bang -range -complete=filetype NN
            \ :<line1>,<line2> call nrrwrgn#NrrwRgn('',<q-bang>)
            \ | set filetype=<args>
" run macro on selection
function! g:ExecuteMacroOverVisualRange()
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" search for visual selection -  from practical vim
function! s:VSetSearch(cmdType)
  let l:temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdType.'\'), '\n', '\\n', 'g')
  let @s = l:temp
endfunction

" show highlight stack
function! SynStack()
  let l:syns = synstack(line('.'), col('.'))
  call map(l:syns, {key, id -> [synIDattr(id, 'name'), synIDattr(synIDtrans(id), 'name')]})
  call map(l:syns, {key, pair -> ('[' . get(pair, 0) . '->' . get(pair, 1) . ']')})
  let l:stack = join(l:syns, ' => ')
  echo l:stack
endfunction

" Delete buffers that are not displayed in any window or modified
function! BufCleanup()
  let l:tabs = map(copy(gettabinfo()), 'v:val.tabnr')

  let l:openBuffers = []
  for l:i in l:tabs
     call extend(l:openBuffers, tabpagebuflist(l:i))
  endfor

  let l:buffers = map(filter(filter(copy(getbufinfo()), 'v:val.listed'), {i, info -> info.changed == v:false}), 'v:val.bufnr')
  for l:bnr in l:buffers
      if index(l:openBuffers, l:bnr) < 0
          exe 'bd '.l:bnr
      endif
  endfor
endfunction

" format a block of JSON with python's built-in function
function! FormatJSON() range
  let l:fullRange = a:firstline.','.a:lastline
  let l:singeLine = a:firstline.','.a:firstline
  silent exe l:fullRange.'join | '.l:singeLine.'! python3 -m "json.tool"'
  silent normal =}
endfunction

function! ToggleSqlScratch(mods)
  let l:sql_scratch_name = get(g:, 'sql_scratch_name', '[sql_scratch]')

  let l:current_tab = tabpagenr()
  let l:page_buffers = tabpagebuflist(l:current_tab)
  let l:page_buffer_names = map(l:page_buffers, {key, val -> bufname(val)})
  let l:is_scratch_open = index(l:page_buffer_names, l:sql_scratch_name) > -1

  if l:is_scratch_open
    let l:scrach_window_number = bufwinnr(l:sql_scratch_name)
    execute l:scrach_window_number.'hide'
  else
    let l:mods = get(a:, 'mods', 'botright')
    execute l:mods 'new' '+setlocal\ buftype=nofile|setlocal\ bufhidden=hide|setlocal\ filetype=sql' l:sql_scratch_name
  endif
endfunction

function! ReadPreview() abort
  if &previewwindow     " don't do this in the preview window
    echo "Can't read inside preview window"
    return
  endif

  silent! wincmd P " to preview window

  if &previewwindow == 0 " couldn't get to preview window
    echo "No preview window open"
    return
  endif

  let l:contents = getline(1, "$")
  wincmd p      " back to old window

  put =l:contents
endfunction

" custom icon overrides
let s:icons = {
\   'jsx': "\ue7ba",
\   'javascript.jsx': "\ue7ba",
\   'nginx': "\ue776",
\ }

function! FilenameWithIcon()
  if exists('*WebDevIconsGetFileTypeSymbol')
    let l:icon = index(keys(s:icons), &filetype) > -1 ? s:icons[&filetype] : WebDevIconsGetFileTypeSymbol()
  else
    let l:icon = ''
  endif
  let l:filename = expand('%')
  return len(l:filename) > 0 ? l:filename . ' ' . l:icon : '[No File]'
endfunction

function! GitVersion()
  let fullname = expand('%')
  let gitversion = ''
  if fullname =~? 'fugitive://.*/\.git//0/.*'
    let gitversion = 'git index'
  elseif fullname =~? 'fugitive://.*/\.git//2/.*'
    let gitversion = 'git target'
  elseif fullname =~? 'fugitive://.*/\.git//3/.*'
    let gitversion = 'git merge'
  elseif &diff == 1
    let gitversion = 'working copy'
  endif
  return gitversion
endfunction

" after.vim loading {{{1
" allow loading of device specific configs
if filereadable(expand('$HOME/init.after.vim'))
  source $HOME/init.after.vim
endif

let git_path = system("git rev-parse --show-toplevel 2>/dev/null")
let git_vimrc = substitute(git_path, '\n', '', '') . "/.vimrc"
if !empty(glob(git_vimrc))
    exec ":source " . git_vimrc
endif

function! HL7AirlineInit()
  call airline#parts#define_function('hl7_segments', 'HL7SegmentInfo')
  call airline#parts#define_condition('hl7_segments', 'expand("%:e") =~ "hl7"')
  let g:airline_section_y = airline#section#create_right(['hl7_segments'])
endfunction

autocmd FileType hl7 call HL7AirlineInit()

" This function adds the segment name and field number to the status line.
function! HL7SegmentInfo()
  let line=getline(".")
  let pieces=split(line,"|")
  let cursorAt = col(".")
  if len(pieces) == 0
    return "No Segment"
  elseif (len(pieces) == 1) || (cursorAt <= strlen(pieces[0]))
    if strlen(pieces[0]) > 3
      return "Invalid segment?"
    else
      return pieces[0]
    endif
  endif
  let seg=pieces[0] . "-"
  let position=strlen(pieces[0])
  let segNum=0
  for index in range(1, len(pieces) - 1)
    let segNum += 1
    let position += 1
    let piece = pieces[index]
    if cursorAt <= (position + strlen(piece))
      return seg . segNum
    endif
    let position += strlen(piece)
  endfor
  " If the last piece was the separator (|) then VIM doesn't treat that
  " as a separate piece so we have to account for this special case.
  if strpart(line, strlen(line)-1, 1) == "|"
    let segNum += 1
  endif
  return seg . segNum
endfunction

function SlimeOverride_EscapeText_elixir(text)
  return substitute(a:text, '\n[\^$]\@=', ' \\\n', 'g')
endfunction

autocmd BufWritePre *.ex lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.exs lua vim.lsp.buf.formatting_sync(nil, 1000)

lua << EOF
local lspconfig = require("lspconfig")

local custom_lsp_attach = function(client, bufrn)
  local opts = { noremap=true, silent=true }
  -- See `:help nvim_buf_set_keymap()` for more information
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- ... and other keymappings for LSP

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Use LSP as the handler for formatexpr.
  --    See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  -- For plugins with an `on_attach` callback, call them here. For example:
  -- require('completion').on_attach()
end

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup our autocompletion. These configuration options are the default ones
-- copied out of the documentation.
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" }
  },
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
      },
    }),
  },
})

lspconfig.efm.setup({
  capabilities = capabilities,
  on_attach = custom_lsp_attach,
  filetypes = {"elixir"}
})

require("trouble").setup {
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
   -- position = "bottom", -- position of the list can be: bottom, top, left, right
   -- height = 10, -- height of the trouble list when position is top or bottom
   -- width = 50, -- width of the list when position is left or right
   -- icons = true, -- use devicons for filenames
   -- mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
   -- fold_open = "", -- icon used for open folds
   -- fold_closed = "", -- icon used for closed folds
   -- group = true, -- group results by file
   -- padding = true, -- add an extra new line on top of the list
   -- action_keys = { -- key mappings for actions in the trouble list
   --     -- map to {} to remove a mapping, for example:
   --     -- close = {},
   --     close = "q", -- close the list
   --     cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
   --     refresh = "r", -- manually refresh
   --     jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
   --     open_split = { "<c-x>" }, -- open buffer in new split
   --     open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
   --     open_tab = { "<c-t>" }, -- open buffer in new tab
   --     jump_close = {"o"}, -- jump to the diagnostic and close the list
   --     toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
   --     toggle_preview = "P", -- toggle auto_preview
   --     hover = "K", -- opens a small popup with the full multiline message
   --     preview = "p", -- preview the diagnostic location
   --     close_folds = {"zM", "zm"}, -- close all folds
   --     open_folds = {"zR", "zr"}, -- open all folds
   --     toggle_fold = {"zA", "za"}, -- toggle fold of current file
   --     previous = "k", -- preview item
   --     next = "j" -- next item
   -- },
   -- indent_lines = true, -- add an indent guide below the fold icons
   -- auto_open = false, -- automatically open the list when you have diagnostics
   -- auto_close = false, -- automatically close the list when you have no diagnostics
   -- auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
   -- auto_fold = false, -- automatically fold a file trouble list at creation
   -- auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
   -- signs = {
   --     -- icons / text used for a diagnostic
   --     error = "",
   --     warning = "",
   --     hint = "",
   --     information = "",
   --     other = "﫠"
   -- },
   -- use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

local path_to_elixirls = vim.fn.expand("/Users/LEX5591/workspace/camiller/dotfiles/language/elixir-ls/release/language_server.sh")

lspconfig.elixirls.setup({
  cmd = {path_to_elixirls},
  settings = {
    elixirLS = {
      mixEnv = "DEV",
      dialyzerEnabled = true,
      fetchDeps = true
    }
  },
  on_attach = custom_lsp_attach
})

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

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
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  }
}

require('telescope').load_extension('fzf')

-- require('nvim-treesitter.configs').setup {
--  ensure_installed = "maintained",
--  sync_install = false,
--  ignore_install = { },
--  highlight = {
--    enable = true,
--    disable = { },
--  },
--
EOF
