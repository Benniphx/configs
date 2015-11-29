"-------------------------------------------------------------------------------

" Required for Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'chriskempson/vim-tomorrow-theme'

Plugin 'airblade/vim-gitgutter'
Plugin 'ap/vim-css-color'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ggreer/the_silver_searcher'
Plugin 'godlygeek/tabular'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

"Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neocomplete.vim'

Plugin 'elixir-lang/vim-elixir'
Plugin 'elzr/vim-json'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'moll/vim-node'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'pearofducks/ansible-vim'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()

"-------------------------------------------------------------------------------

filetype plugin indent on

set mouse=a                     " enable mouse in all modes
set ttymouse=xterm2             " terminal that supports mouse codes

set clipboard=unnamedplus       " copy to system clipboard
set paste                       " paste from a windows or from vim
set go+=a                       " visual selection automatically copied to the clipboard

set hidden                      " hide buffers instead of closing them
set ttyfast                     " smoother changes
set lazyredraw                  " don't draw unless necessary
set title                       " try to show the filename in the terminal title
set shortmess=aTItoO            " disable the splash-screen
set viminfo='500,f1,:100,/100   " history settings
set visualbell t_vb=            " turn off error sound/flash
set novisualbell                " turn off visual bell
set noerrorbells                " disable error bells

syntax on                       " use syntax highlighting
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
set list listchars=tab:»·,trail:·

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

set t_Co=256                      " number of colors to use
set background=dark
colorscheme Tomorrow-Night-Bright " colorscheme to use

" make the statusbar more informative
if has("statusline")
  set laststatus=2
  set statusline=\ \ %F%m%r%h%w\ %=[%Y]\ (%{&ff},\ %{&enc})\ \{%v,\ %l/%L\}\ \ %p%%\
endif

"-------------------------------------------------------------------------------

" toggling paste indenting mode
noremap <silent> <F2> :set invpaste<CR>:set paste?<CR>

" toggling wrapping
noremap <silent> <F3> :set invwrap<CR>:set wrap?<CR>

" toggling displaying of invisible characters
noremap <silent> <F4> :set invlist<CR>:set list?<CR>

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

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Neocomplete
let g:neocomplete#enable_at_startup = 1

" NERDtree
let g:NERDTreeWinPos='right'
let g:NERDTreeWinSize=30
let g:NERDChristmasTree=1
let g:NERDTreeShowLineNumbers=0
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
let g:NERDTreeMouseMode=3
nnoremap <C-e> :NERDTreeToggle<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
