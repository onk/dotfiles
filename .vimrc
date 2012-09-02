" ======================================================================
" NeoVundle
" ----------------------------------------------------------------------
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/neobundle.vim'

" ======================================================================
" plugins
" ----------------------------------------------------------------------
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'int3/vim-extradite'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'othree/eregex.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/operator-camelize.vim'
NeoBundle 'yuroyoro/monday'
NeoBundle 'hallison/vim-markdown'

NeoBundle 'sequence'
NeoBundle 'svn-diff.vim'
NeoBundle 'klen/vim-taglist-plus'
NeoBundle 'yanktmp.vim'

" colors
NeoBundle 'tpope/vim-vividchalk'

" =====================================================================
" basic options
" ----------------------------------------------------------------------
filetype on
filetype indent on
filetype plugin on
syntax on

set nobackup
set noswapfile
set autoread

set number
set ruler
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:\
set showmatch

set hlsearch
set ignorecase
set smartcase
set wrapscan
set incsearch

set wildmenu
set wildmode=list:longest

set showcmd
set showmode

set showtabline=2
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent

set laststatus=2
set statusline=\ [%02n]                                          "number of buffer
set statusline+=\ %F                                             "file name
set statusline+=\ %m\ %r\ %h\ %w                                 "読み込み専用ファイルはRO,変更されたら+とか
set statusline+=[%{&fileencoding}\ %{&fileformat}\ %{&filetype}]
set statusline+=%=\ %{fugitive#statusline()}                     "git  branch 表示
set statusline+=\ (%l/%L,%v)                                     "行/行数、列

set nrformats-=octal
set textwidth=0

set scrolloff=5

set backspace=indent,eol,start
set virtualedit+=block

set foldmethod=syntax
set foldlevel=99

set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set helplang=ja,en

" 表示行単位の移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
nnoremap 0 g0
nnoremap g0 0
nnoremap $ g$
nnoremap g$ $
vnoremap 0 g0
vnoremap g0 0
vnoremap $ g$
vnoremap g$ $

" window 操作
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l

" 検索後、真ん中にフォーカスをあわせる
" 検索時，folding を考慮
nnoremap n  nzvzz
nnoremap N  Nzvzz
nnoremap *  *zvzz
nnoremap #  #zvzz
nnoremap g* g*zvzz
nnoremap g# g#zvzz

" Open a new tab page and edit the file name under the cursor.
nnoremap gf <C-w>gf
nnoremap <C-w>gf gf

" folding
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" QuickFix を自動で開く
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | endif

"" Remove trailing spaces
function! RTrim()
  let s:cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", s:cursor)
endfunction
" autocmd BufWritePre * call RTrim()
"
" 改行時の自動コメントを抑制
autocmd FileType * setlocal formatoptions-=r " 挿入モードで改行した時に # を自動挿入しない
autocmd FileType * setlocal formatoptions-=o " ノーマルモードで o や O をした時に # を自動挿入しない
autocmd FileType * setlocal formatoptions+=j " jJ で join したときに行頭コメントを除去する

" rubyマジックコメント
iab u8 # -*- coding: utf-8 -*-
" ruby puts マーカー
iab p= p "= 1 ====================================================================="

" ハイライトを無効に
nnoremap <Esc><Esc> :nohlsearch<CR>

" =====================================================================
" plugin options
" ----------------------------------------------------------------------
" LeafCage/foldCC
" @see http://d.hatena.ne.jp/leafcage/20111223/1324705686
set foldtext=FoldCCtext()
set foldcolumn=2
set fillchars=vert:\|
noremap <silent> <C-g> :echo FoldCCnavi()<CR>

" nathanaelkane/vim-indent-guides
let indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233
let g:indent_guides_enable_on_vim_startup = 1

" othree/eregex.vim
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

" scrooloose/nerdcommenter
let NERDSpaceDelims = 1
let NERDShutUp = 1

" thinca/vim-quickrun
augroup QuickrunRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
let g:quickrun_config = {}
let g:quickrun_config._ = { 'runner' : 'vimproc' }
let g:quickrun_config['ruby.rspec'] = { 'command' : 'rspec', 'split'   : '' }
let g:quickrun_config['markdown'] = { 'command' : 'pandoc',
      \ 'exec': ['%c -s -f markdown -t html -o %s:p:r.html %s', 'w3m %s:p:r.html', 'sleep 1', 'rm %s:p:r.html'],
      \ 'tempfile': '{tempname()}.md' }

" tyru/operator-camelize.vim
vmap <Leader>c <Plug>(operator-camelize)
vmap <Leader>C <Plug>(operator-decamelize)

" vim-taglist-plus
nnoremap <silent> <C-o> :<C-u>Tlist<CR>

" yanktmp.vim
noremap <silent> sy :call YanktmpYank()<CR>
noremap <silent> sp :call YanktmpPaste_p()<CR>
noremap <silent> sP :call YanktmpPaste_P()<CR>

" ======================================================================
" color
" ----------------------------------------------------------------------
" 色指定
set t_Co=256
colorscheme vividchalk

" カーソル行を強調
set cursorline
highlight CursorLine ctermbg=234 cterm=NONE

" 全角スペースをハイライトする
highlight JpSpace cterm=underline ctermfg=Blue
autocmd BufRead,BufNew * match JpSpace /　/

" 挿入モード時、ステータスラインの色を変える
autocmd InsertEnter * highlight StatusLine ctermbg=Red  ctermfg=White
autocmd InsertLeave * highlight StatusLine ctermbg=Grey ctermfg=Black

hi Search term=reverse ctermfg=black ctermbg=brown

" 指定の横幅以上はハイライトする (vim 7.3 以上)
" @see http://vim-users.jp/2010/09/hack172/
if exists('&colorcolumn')
  set colorcolumn=+1
  autocmd FileType sh,cpp,perl,vim,ruby,python,haskell,scheme,markdown setlocal textwidth=80
endif

" ======================================================================
" Misc
" ----------------------------------------------------------------------
augroup Binary
  autocmd!
  autocmd BufReadPre  *.swf let &bin=1
  autocmd BufReadPost *.swf if &bin | %!xxd
  autocmd BufReadPost *.swf set ft=xxd | endif
  autocmd BufWritePre *.swf if &bin | %!xxd -r
  autocmd BufWritePre *.swf endif
  autocmd BufWritePost *.swf if &bin | %!xxd
  autocmd BufWritePost *.swf set nomod | endif
augroup END

" shebang がある場合は保存時に実行権限付与
autocmd BufWritePost * :call AddExecmod()
function AddExecmod()
  let line = getline(1)
  if strpart(line, 0, 2) == "#!"
    call system("chmod +x ". expand("%"))
  endif
endfunction

