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
" Plug 'christoomey/vim-tmux-navigator'

Plug 'simnalamburt/vim-mundo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

Plug 'sheerun/vim-polyglot'
Plug 'exu/pgsql.vim'
" Plug 'Shougo/neco-vim'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/SyntaxRange'

Plug 'w0rp/ale'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'      "ae/ie for entire file
Plug 'kana/vim-textobj-indent'      "ai/ii for indent block
Plug 'kana/vim-textobj-line'        "al/il for line
Plug 'sgur/vim-textobj-parameter'   "a,/i, for argument/parameter
Plug 'aoswalt/vim-textobj-elixir'   "aE/iE for Elixir blocks as remapped
Plug 'Julian/vim-textobj-variable-segment'    "av/iv for variable part
Plug 'Chun-Yang/vim-textobj-chunk'  "ac/ic for json-ish chunk
Plug 'whatyouhide/vim-textobj-xmlattr'  "ax/ix for xml attribute

" Plug 'thinca/vim-quickrun'
" Plug 'tpope/vim-dispatch'
" Plug 'radenling/vim-dispatch-neovim'
Plug 'vim-scripts/dbext.vim'
" Plug 'suan/vim-instant-markdown', { 'do': 'npm install -g instant-markdown-d' }
Plug 'chrisbra/csv.vim'
Plug 'junegunn/vim-peekaboo'

" Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'systemmonkey42/vim-coloresque'
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
" Plug 'tpope/vim-obsession'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
" Plug 'SirVer/ultisnips'
Plug 'tpope/vim-dadbod'

" Plug 'aoswalt/onedark.vim'
" Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'markvincze/panda-vim'
Plug 'w0ng/vim-hybrid'

" Plug 'wannesm/wmgraphviz.vim'

" Plug 'junegunn/limelight.vim'

" ctags require https://github.com/universal-ctags/ctags
" Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'rizzatti/dash.vim'
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'diepm/vim-rest-console'

" Plug 'reasonml-editor/vim-reason-plus'
Plug 'wesQ3/vim-windowswap'

Plug 'neoclide/jsonc.vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
Plug 'antoinemadec/coc-fzf'

" Plug 'chrisbra/NrrwRgn'

Plug 'vim-test/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'elixir-editors/vim-elixir'

call plug#end()

let g:ale_linters = {
\  'sql': ['sqlint'],
\}

let g:ale_fixers = {
\  'sql': ['pgformatter'],
\  'html': ['htmlbeautifier'],
\  'eelixir': ['htmlbeautifier'],
\}

let g:ale_sql_pgformatter_options = "
\ --comma-start
\ --comma-break
\ --spaces 2
\ --keyword-case 2
\ --type-case 2
\ --wrap-after 1
\ --placeholder ':: '
\"

let s:coc_extensions = [
\   'coc-css',
\   'coc-html',
\   'coc-json',
\   'coc-eslint',
\   'coc-prettier',
\   'coc-tsserver',
\ ]

 if exists('*coc#add_extension')
  call call('coc#add_extension', s:coc_extensions)
endif

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

" fix to not require extra keypress for fzf in terminal
let $FZF_DEFAULT_OPTS .= ' --no-height'


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
nnoremap <silent> gj :wincmd j<CR>
nnoremap <silent> gk :wincmd k<CR>
nnoremap <silent> gl :wincmd l<CR>

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
" Swap Windows
nnoremap <silent> gx :wincmd x<CR>

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

" Highlight search word under cursor without jumping to next
" nnoremap <leader>h *<C-O>

" Toggle spelling mode
nnoremap <silent> <leader>sp :set spell!<CR>

" Quickly switch to last buffer
" nnoremap <leader>, :e#<CR>

" Split window vertically or horizontally *and* switch to the new split!
nnoremap <silent> <leader>hs :split<Bar>:wincmd j<CR>:wincmd =<CR>
nnoremap <silent> <leader>vs :vsplit<Bar>:wincmd l<CR>:wincmd =<CR>

nnoremap <C-y> "*y
vnoremap <C-y> "*y

nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <leader>r :%s/
vnoremap <leader>r :s/

vnoremap // y/<C-R>"<CR>

" nmap ghp <Plug>(GitGutterPreviewHunk)
" nmap ghs <Plug>(GitGutterStageHunk)
" nmap ghu <Plug>(GitGutterUndoHunk)

if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

" plugin settings {{{1
let g:netrw_altfile = 1   "allow <c-6> to go to the previously edited file
let g:netrw_preview = 1   "open preview window in a vertical split
let g:netrw_localrmdir="rm -r"  "allow deleting non-empty directories

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1

let g:highlightedyank_highlight_duration = 350

let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"

let g:vim_textobj_elixir_mapping = 'E'

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:quickrun_config = {}
let g:quickrun_config['javascript.jsx'] = { 'type': 'javascript' }
let g:quickrun_config['sh'] = { 'type': 'bash' }

let g:sql_type_default = 'pgsql'

let g:fzf_commands_expect = 'enter,ctrl-x'

" autocommands {{{1
augroup whitespace
  " automatically strip trailiing whitespace on save
  autocmd BufWritePre * StripWhitespace
augroup end

" augroup dispatch_commands
"   autocmd FileType sh let b:dispatch = '$SHELL %'
"   autocmd FileType dot let b:dispatch = 'dot -Tpng % -o %:r.png'
" augroup end

augroup ft_match_words
  " add do/end as jumps for %
  autocmd FileType elixir let b:match_words = '\<do\>:\<end\>'
augroup end

" switch to current file's parent directory
" set autochdir was causing issues with some plugins but needs reinvestigating
" augroup vimrc_set_working_dir
"   au!
"   autocmd BufRead,BufEnter * silent! lcd %:p:h
" augroup end

" only show cursor line one active window
" augroup cursorLine
"   autocmd!
"   autocmd BufEnter * setlocal cursorline
"   autocmd BufLeave * setlocal nocursorline
" augroup end

" set cursorline
" autocmd InsertEnter * highlight CursorLine guibg=#000050 guifg=fg
" autocmd InsertLeave * highlight CursorLine guibg=#444444 guifg=fg

highlight cursorline ctermbg=black

" use pgsql syntax inside elixir non-doc string blocks
augroup elixirAdditionalSyntax
  autocmd!
  autocmd FileType elixir call SyntaxRange#Include('\s\{2,\}\"\"\"', '\"\"\"', 'pgsql', 'NonText')
  autocmd FileType elixir call SyntaxRange#Include('calc(\"\"\"', '\"\"\"', 'javascript', 'Text')
augroup end

augroup pum
  " auto-close preview pane
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end

augroup term_settings
  autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup end

augroup term_insert
  " go into insert mode if switching to a terminal buffer
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

" colors {{{1
colorscheme dracula

highlight! IndentGuidesOdd  ctermbg=233
highlight! IndentGuidesEven ctermbg=234

highlight! jsBlock ctermfg=150
highlight! jsObjectKey ctermfg=139
highlight! Normal ctermbg=NONE

" highlight! link TermCursor Cursor
highlight! TermCursorNC ctermbg=0 ctermfg=15

highlight Pmenu ctermbg=darkgray ctermfg=white
highlight PmenuSel ctermbg=lightgray ctermfg=black
highlight ErrorMsg guifg=black
highlight link Constant DraculaPurple
highlight link elixirArguments DraculaOrange

highlight Comment cterm=italic gui=italic ctermfg=18

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

" warning mappings lke unimpaired
nmap <silent> [W <Plug>(coc-diagnostic-first)
nmap <silent> [w <Plug>(coc-diagnostic-previous)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <silent> ]W <Plug>(coc-diagnostic-last)

" terminal keybindings
au TermOpen * tnoremap <buffer> <Esc><Esc> <c-\><c-n>
au FileType fzf tunmap <buffer> <Esc><Esc>
tnoremap <m-h> <c-\><c-n><c-w>h
tnoremap <m-j> <c-\><c-n><c-w>j
tnoremap <m-k> <c-\><c-n><c-w>k
tnoremap <m-l> <c-\><c-n><c-w>l

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

" super find
nnoremap <leader>f :GFiles -co --exclude-per-directory=.gitignore<CR>
nnoremap <leader>F :FZF<CR>

" super search
nnoremap <leader>/ :Rg<space>
nnoremap <leader>? :BLines<space>

" buffer management
nnoremap <leader>b :Buffers<cr>
nnoremap <c-up> :ls<cr>:b
nnoremap <c-right> :bn<cr>
nnoremap <c-left> :bp<cr>
nnoremap <c-down> :bn \| bd #<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :bd<cr>

" search for word under cursor with <leader>*
nnoremap <leader>* :Rg <c-r><c-w><CR>
nnoremap <leader>& "myiW :Rg <c-r>m<CR>

" system clipboard yank
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P

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

" format
augroup format
  autocmd FileType * nmap <F4> <plug>(coc-format)
  autocmd FileType sql nmap <buffer> <F4> <Plug>(ale_fix)
  autocmd FileType eelixir nmap <buffer> <F4> <Plug>(ale_fix)
  autocmd FileType html nmap <buffer> <F4> <Plug>(ale_fix)
augroup end

" augroup fzfbindings
"   autocmd BufEnter FileType fzf tunmap <esc><esc>
"   " autocmd BufLeave FileType fzf tnoremap <esc><esc> <c-\><c-n>
" augroup end

" run fixer
nmap <F6> <plug>(coc-fix-current)

" full info
nmap <F10> <plug>(coc-diagnostic-info)

" pane toggles
nnoremap <F5> :MundoToggle<CR>
nnoremap <F8>  :TagbarToggle<CR>

" edit vimrc/zshrc and source vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>sf :source %<CR>

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

fun! MapLCKeys()
  " Don't map for built-in ones
  if &ft =~ 'vim\|help\|shell'
    return
  endif

  nmap <buffer> <F3> <plug>(coc-rename)
  nnoremap <buffer> <silent> K :call CocAction('doHover')<CR>
  nnoremap <buffer> <silent> <C-w><C-k> :call CocAction('showSignatureHelp')<CR>

  nmap <buffer> gd <plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent> <leader>co  :CocList outline<CR>
endfun

autocmd FileType * call MapLCKeys()

" commands {{{1
" close all other buffers
command! BufOnly :%bd|e#

command! BufCleanup :call BufCleanup()
command! SynStack :call SynStack()

" open a terminal in a different view while setting bufhidden to hide to keep alive
command! -nargs=* VTerm :vsp
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

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" fugitive bindings
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gL :Git log -p<cr>
nnoremap <leader>gr :Grebase -i --autosquash

nnoremap <leader>tn :w<CR>:TestNearest<CR>

nnoremap <leader>mcp :!mix compile<CR>
nnoremap <leader>mcd :!mix credo --strict<CR>
nnoremap <leader>mf :!mix format<CR>

nnoremap <F10> :echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<' . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'<CR>

command! -range FormatJSON :<line1>,<line2>call FormatJSON()

command! -nargs=* Gpc execute('Gpush --set-upstream origin '.FugitiveHead().' '.<q-args>)

command! ToggleSqlScratch :call ToggleSqlScratch(<q-mods>)

command! ReadPreview call ReadPreview()

" air-line
let g:airline_powerline_fonts = 1

"YouCompleteMe
"let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'ruby' : 1,
    \}

let g:ycm_semantic_triggers =  {
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'gitcommit' : ['#', ':'],
  \ }


" Overwritten so we can allow markdown completion.
let g:ycm_filetype_blacklist = {
  \ 'notes': 1,
  \ 'unite': 1,
  \ 'tagbar': 1,
  \ 'pandoc': 1,
  \ 'qf': 1,
  \ 'vimwiki': 1,
  \ 'text': 1,
  \ 'infolog': 1,
  \ 'mail': 1
\}

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

" override Ag and Rg commands to search inside git repo and add preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'dir': FugitiveWorkTree()}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
    \ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
    \ 1,
    \ fzf#vim#with_preview({'dir': FugitiveWorkTree()}),
    \ <bang>0
  \ )

" override GFiles to add preview
command! -bang -nargs=? GFiles
    \ call fzf#vim#gitfiles(
    \ '-co --exclude-per-directory=.gitignore',
    \ fzf#vim#with_preview(),
    \ <bang>0
  \ )

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

