if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

" ======================================================================
" plugins
" ----------------------------------------------------------------------
NeoBundle 'LeafCage/foldCC'
NeoBundle 'Shougo/vimproc'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'

" colors
NeoBundle 'tpope/vim-vividchalk'

filetype plugin indent on
syntax on

" LeafCage/foldCC
" @see http://d.hatena.ne.jp/leafcage/20111223/1324705686
set foldtext=FoldCCtext()
set fillchars=vert:\|
let g:foldCCtext_tail = 'printf("   %s[%4d lines  Lv%-2d]%s",
    \ v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'

" nathanaelkane/vim-indent-guides
let indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233
let g:indent_guides_enable_on_vim_startup = 1

" thinca/vim-quickrun
augroup QuickrunRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
  " @see http://qiita.com/joker1007/items/69035c454de416849b8a
  nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -cmdopt \"-l " . line(".") . "\"<CR>"
augroup END
let g:quickrun_config = {}
let g:quickrun_config._ = { 'runner' : 'vimproc' }
let g:quickrun_config['ruby.rspec'] = {
    \ 'command' : 'rspec',
    \ 'exec' : 'bundle exec %c %o %s %a',
    \ 'split' : '',
    \ 'runner/vimproc/updatetime' : 10,
    \ }

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
set foldmethod=syntax
set foldlevel=99
set number
set ambiwidth=double

" folding
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" ======================================================================
" color
" ----------------------------------------------------------------------
set t_Co=256
colorscheme vividchalk
set background=dark
