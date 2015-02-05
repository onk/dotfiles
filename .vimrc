if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

" ======================================================================
" plugins
" ----------------------------------------------------------------------
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tpope/vim-fugitive'

" colors
NeoBundle 'tpope/vim-vividchalk'

filetype plugin indent on
syntax on

" =====================================================================
" basic options
" ----------------------------------------------------------------------
set noswapfile
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set hlsearch
set ignorecase
set smartcase
set wrapscan
set incsearch
set scrolloff=5

" ======================================================================
" color
" ----------------------------------------------------------------------
set t_Co=256
colorscheme vividchalk
set background=dark
