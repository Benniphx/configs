"===============================================================================

" load bundles
call pathogen#infect()

"-------------------------------------------------------------------------------

" mouse settings
set mouse=a                     " enable mouse in all modes
set ttymouse=xterm2             " terminal that supports mouse codes

" editor settings
set hidden                      " hide buffers instead of closing them
set nocompatible                " disable vi compatible mode
set ttyfast                     " smoother changes
set lazyredraw                  " don't draw unless necessary
set title                       " try to show the filename in the terminal title
set shortmess=aTItoO            " disable the splash-screen
set viminfo='500,f1,:100,/100   " history settings
set visualbell t_vb=            " turn off error sound/flash
set novisualbell                " turn off visual bell
set noerrorbells                " disable error bells

syntax on                       " use syntax highlighting
filetype plugin indent on       " enable plugins and indentation
set fileformats=unix,dos,mac    " try to detect line endings of the file

set showmode                    " display editing mode
set showcmd                     " display possible commands when tab is pressed
set history=50                  " make command history longer
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.log,*.obj,*.o,*.jpg,*.png,*.gif,*.swp,vendor/rails/**

set nostartofline               " don't jump to the first column when scrolling
set scrolloff=5                 " keep n lines around cursor when scrolling vertically
set sidescrolloff=10            " keep n columns around cursor when scrolling horizontally

set tabstop=4                   " number of spaces for a tab
set softtabstop=4               " number of spaces to insert when tab/backspace
set shiftwidth=4                " number of spaces to insert on indent
set smarttab                    " uses shiftwidth instead of tabstop at s.o.l
set expandtab                   " expand tabs to spaces
set backspace=indent,eol,start  " enable backspace for these actions

set number                      " display line numbers
set foldlevel=100               " fold nothing by default
set foldcolumn=1                " the width of the fold column

set showmatch                   " show brace matches
set matchpairs+=<:>             " include angle brackets into brace matches
set matchtime=5                 " how many 0.1s to blink for
set iskeyword+=_,$,@,%,#,-      " disable these as word dividers

set hlsearch                    " highlight matching searches
set incsearch                   " move cursor to the matched string
set ignorecase                  " ignore case when searching
set smartcase                   " don't ignore case if already uppercase

set nowrap                      " no wrap by default
set whichwrap+=<,>,[,]          " wrap also when using arrow keys

set autoindent                  " indentation settings
set smartindent
set cindent

set nobackup                    " don't keep backup after close
set writebackup                 " do keep a backup while working
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set tags=tags,./tags,tmp/tags,./tmp/tags

"-------------------------------------------------------------------------------

" use this theme
set t_Co=256                      " number of colors to use
colorscheme Tomorrow-Night-Bright " colorscheme to use

" make the statusbar more informative
if has("statusline")
  set laststatus=2
  set statusline=\ \ %F%m%r%h%w\ %=[%Y]\ (%{&ff},\ %{&enc})\ \{%v,\ %l/%L\}\ \ %p%%\
endif

"-------------------------------------------------------------------------------

" clipboard
set clipboard=unnamed

"-------------------------------------------------------------------------------

" ctrl+a is select all
noremap <C-A>       gggH<C-O>G
inoremap <C-A>      <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A>      <C-C>gggH<C-O>G
onoremap <C-A>      <C-C>gggH<C-O>G
snoremap <C-A>      <C-C>gggH<C-O>G
xnoremap <C-A>      <C-C>ggVG

"-------------------------------------------------------------------------------

" toggling paste indenting mode
noremap <silent> <F2> :set invpaste<CR>:set paste?<CR>
set paste

" toggling wrapping
noremap <silent> <F3> :set invwrap<CR>:set wrap?<CR>

" toggling displaying of invisible characters
noremap <silent> <F4> :set invlist<CR>:set list?<CR>
set list listchars=tab:»·,trail:·

" strip all trailing whitespaces
noremap <silent> <F5> :%s/\s\+$//<CR>:let @/=''<CR>

" convert tabs to spaces
:command! -range=% -nargs=0 Tab2Space execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
noremap <silent> <F6> :Tab2Space<CR>

" convert spaces to tabs
:command! -range=% -nargs=0 Space2Tab execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"
noremap <silent> <F7> :Space2Tab<CR>

"-------------------------------------------------------------------------------

" enable tab indent and shift+tab unindent also in visual mode
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

" switching buffers
nnoremap <C-n> :bnext<cr>
nnoremap <C-p> :bprev<cr>

" change autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

"-------------------------------------------------------------------------------

" Command-T
let g:CommandTMatchWindowAtTop=1
let g:CommandTMaxHeight=30
nmap <C-d> :CommandT<CR>

" Minibufexpl.vim
let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplMaxSize=3
let g:miniBufExplSplitBelow=0
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplUseSingleClick=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplorerDebugLevel=0
let g:miniBufExplorerDebugMode=3
nnoremap <C-b> :TMiniBufExplorer<cr>

" NERDtree
let g:NERDTreeWinPos='right'
let g:NERDTreeWinSize=30
let g:NERDChristmasTree=1
let g:NERDTreeShowLineNumbers=0
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let g:NERDTreeMouseMode=3
nnoremap <C-e> :NERDTreeToggle<CR>

" Taglist
let g:Tlist_Auto_Open=0
let g:Tlist_Use_Left_Window=1
let g:Tlist_WinWidth=24
let g:Tlist_Sort_Type = "name"
let g:Tlist_Use_SingleClick=1
let g:Tlist_Compact_Format=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_File_Fold_Auto_Close=1
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Show_Menu=1
let g:Tlist_Show_One_File=1
nnoremap <C-f> :TlistToggle<CR>

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
let g:SuperTabNoCompleteAfter=[',', '\s']
let g:SuperTabMappingForward='<C-b>'
let g:SuperTabMappingBackward='<C-S-b>'

"-------------------------------------------------------------------------------

" Ruby additions
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
      \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set filetype=ruby
autocmd BufRead,BufNewFile jquery.*.js        set filetype=javascript syntax=jquery
autocmd BufRead,BufNewFile *.rd,*.rdoc        set filetype=rdoc
autocmd BufNewFile,BufRead *.haml             set ft=haml
autocmd BufNewFile,BufRead *.feature,*.story  set ft=cucumber
autocmd BufRead * if ! did_filetype() && getline(1)." ".getline(2).
      \ " ".getline(3) =~? '<\%(!DOCTYPE \)\=html\>' | setf html | endif

autocmd FileType javascript,coffee      setlocal et sw=2 sts=2 isk+=$
autocmd FileType html,xhtml,css,scss    setlocal et sw=2 sts=2
autocmd FileType eruby,yaml,ruby        setlocal et sw=2 sts=2
autocmd FileType cucumber               setlocal et sw=2 sts=2
autocmd FileType sh,csh,zsh             setlocal et sw=2 sts=2
autocmd FileType gitcommit              setlocal spell
autocmd FileType gitconfig              setlocal noet sw=4
autocmd FileType ruby                   setlocal comments=:#\  tw=79
autocmd FileType vim                    setlocal et sw=2 sts=2 keywordprg=:help

" these are not enabled by default in vim-ruby anymore
autocmd FileType ruby,eruby,yaml,haml   let g:rubycomplete_rails=1
autocmd FileType ruby,eruby,yaml,haml   let g:rubycomplete_buffer_loading=1
autocmd FileType ruby,eruby,yaml,haml   let g:rubycomplete_classes_in_global=1

autocmd Syntax   css                    syn sync minlines=50
