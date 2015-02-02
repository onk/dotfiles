if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

filetype plugin indent on
syntax on

" ======================================================================
" plugins
" ----------------------------------------------------------------------
NeoBundle 'h1mesuke/vim-alignta'

" =====================================================================
" basic options
" ----------------------------------------------------------------------
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
