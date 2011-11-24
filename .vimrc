set nocompatible

" ======================================================================
" Vundle
" ----------------------------------------------------------------------
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" plugin
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'chrismetcalf/vim-taglist'
Bundle 'davidoc/taskpaper.vim'
Bundle 'mattn/calendar-vim'
Bundle 'mattn/webapi-vim'
Bundle 'othree/eregex.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'thinca/vim-quickrun'
Bundle 'toritori0318/vim-redmine'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'yuroyoro/monday'

Bundle 'Align'
Bundle 'bufexplorer.zip'
Bundle 'nginx.vim'
Bundle 'svn-diff.vim'
Bundle 'yanktmp.vim'

" color
Bundle 'tpope/vim-vividchalk'
Bundle 'wombat256.vim'


" ======================================================================
" 基本設定
" ----------------------------------------------------------------------
set scrolloff=5           " カーソル移動時の上下の余白
set modelines=0           " モードラインは無効
set nobackup              " バックアップ取らない
set noswapfile            " swap ファイルは作らない
set autoread              " 開いているファイルが編集されると再読み込み
"set hidden                " バッファが編集中でも次のファイルを開ける
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set wildmode=list,longest " コマンドライン補間をシェルっぽく
set wildmenu              " 補間候補を表示
set list                  " 特殊文字を表示
set listchars=tab:>-,trail:-,nbsp:%,extends:\
set number                " 行番号を表示
set ruler                 " 列番号を表示
set cursorline            " カーソルラインの下線を表示
set hlsearch              " 検索時の自動ハイライト
"set incsearch             " 検索モード：インクリメンタルサーチ
set ignorecase            " 大文字小文字を区別なく検索
set smartcase             " 大文字から始まる場合は区別して検索
set wrapscan              " 検索時に最後まで行ったら最初に戻る
set showcmd               " 入力中のコマンドを表示
set showmode              " 現在のモードを表示
set showmatch             " 対応する括弧を表示
set laststatus=2          " ステータスバーを常に表示
set showtabline=2         " タブバーを常に表示
set expandtab
set tabstop=2             " tab 文字を画面上で何文字に表示するか
set softtabstop=2         " tab キー押下時のインデント量
set shiftwidth=2          " autoindent 時に挿入されるインデント量
set autoindent            " indent
set smartindent
set helplang=ja,en        " helpの言語の優先順位
set virtualedit+=block    " ヴィジュアルモードで仮想編集可能 (文字のないところにもカーソル移動可) に
set nrformats=hex         " <C-x>,<C-a> で使う基数
set textwidth=0           " 一行に長い文章を書いていても自動折り返しをしない

" folding
set foldmethod=syntax     " syntax に依存して folding を行う
set foldlevel=99          " folding は行わない
set foldcolumn=0          " fold 時のツリー表示は行わない

" statusline
set statusline=\ [%02n]                                          "number of buffer
set statusline+=\ %F                                             "file name
set statusline+=\ %m\ %r\ %h\ %w                                 "読み込み専用ファイルはRO,変更されたら+とか
set statusline+=[%{&fileencoding}\ %{&fileformat}\ %{&filetype}]
set statusline+=%=\ (%l/%L,%v)                                   "行/行数、列

" 文字化け対策
set fileencodings=utf-8,cp932,euc-jp    " 文字コード
set fileformats=unix,dos,mac            " 改行文字

" ファイルタイプに関連づけられた設定を読み込む
filetype on
filetype indent on
filetype plugin on
" 強調表示
syntax on

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

" スクロール
nnoremap J <C-e>j
nnoremap K <C-y>k
nnoremap <C-e> <C-e>j
nnoremap <C-y> <C-y>k
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" window 操作
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l

nnoremap <silent> <C-x>1 :only<CR>
nnoremap <silent> <C-x>2 :sp<CR>
nnoremap <silent> <C-x>3 :vsp<CR>

" window resize
nnoremap w+ 4<C-w>+
nnoremap w- 4<C-w>-
nnoremap w, 4<C-w><
nnoremap w. 4<C-w>>

" tab 操作
nnoremap tn :<C-u>tabnext<CR>
nnoremap tp :<C-u>tabprev<CR>

" 検索後、真ん中にフォーカスをあわせる
" 検索時，folding を考慮
nnoremap n  nzvzz
nnoremap N  Nzvzz
nnoremap *  *zvzz
nnoremap #  #zvzz
nnoremap g* g*zvzz
nnoremap g# g#zvzz

" brackets"
" inoremap {} {}<LEFT>
" inoremap [] []<LEFT>
" inoremap () ()<LEFT>
" inoremap <> <><LEFT>

" 行頭で h を押すと折畳を閉じる。
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" 折畳上で l を押すと折畳を開く。
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" 行頭で h を押すと選択範囲に含まれる折畳を閉じる。
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" 折畳上で l を押すと選択範囲に含まれる折畳を開く。
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" QuickFix を自動で開く
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | endif

"" Remove trailing spaces
function! RTrim()
  let s:cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", s:cursor)
endfunction
autocmd BufWritePre * call RTrim()

" 改行時の自動コメントを抑制
autocmd FileType * setlocal formatoptions-=r " 挿入モードで改行した時に # を自動挿入しない
autocmd FileType * setlocal formatoptions-=o " ノーマルモードで o や O をした時に # を自動挿入しない

"rubyマジックコメント
iab u8 # -*- coding: utf-8 -*-

" datetime 挿入
imap <silent> <C-D><C-D> <C-R>=strftime("%Y-%m-%d")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%H:%M")<CR>

" ハイライトを無効に
nnoremap <Esc><Esc> :nohlsearch<CR>

" =====================================================================
" plugin
" ----------------------------------------------------------------------
" Shougo/neocomplcache
"let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
"
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Shougo/vimproc

" chrismetcalf/vim-taglist
nnoremap <silent> <C-o> :<C-u>Tlist<CR>

" mattn/calendar-vim
let g:calendar_monday = 1
let g:calendar_action = ''

" mattn/webapi-vim
" othree/eregex.vim

" scrooloose/nerdcommenter
let NERDSpaceDelims = 1 " コメントの間にスペースを空ける
let NERDShutUp = 1      " 対応していないファイルに対して警告をしない

"thinca/vim-quickrun
augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
let g:quickrun_config = {}
let g:quickrun_config['*'] = {'split' : ''} " 横分割 (画面上部に test を表示)
let g:quickrun_config['ruby.rspec'] = { 'command' : 'rspec','runmode':"async:vimproc"}

" toritori0318/vim-redmine
" tpope/vim-fugitive
" tpope/vim-rails
" tpope/vim-surround
let g:surround_{char2nr('#')} = "#{\r}"
let g:surround_{char2nr('e')} = "begin \r end"
let g:surround_{char2nr('i')} = "if \1if\1 \r end"
let g:surround_{char2nr('u')} = "unless \1unless\1 \r end"
let g:surround_{char2nr('b')} = "\1method\1 do \2args\r..*\r|&| \2\r end"
let g:surround_{char2nr('B')} = "\1method\1 {\2args\r..*\r|&|\2 \r }"

" vim-ruby/vim-ruby
"setlocal omnifunc=syntaxcomplete#Complete

" Align

" bufexplorer.zip
nnoremap <silent> <C-l> :<C-u>BufExplorer<CR>

" yanktmp.vim
noremap <silent> sy :call YanktmpYank()<CR>
noremap <silent> sp :call YanktmpPaste_p()<CR>
noremap <silent> sP :call YanktmpPaste_P()<CR>


" ======================================================================
" color
" ----------------------------------------------------------------------
" 色指定
"colorscheme wombat256mod
colorscheme vividchalk

" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
highlight CursorLine ctermbg=black guibg=black

" 全角スペースをハイライトする
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
autocmd BufRead,BufNew * match JpSpace /　/

" 挿入モード時、ステータスラインの色を変える
autocmd InsertEnter * highlight StatusLine ctermfg=DarkRed guifg=DarkRed
autocmd InsertLeave * highlight StatusLine ctermfg=Black guifg=Black

" 指定の横幅以上はハイライトする (vim 7.3 以上)
" @see http://vim-users.jp/2010/09/hack172/
if exists('&colorcolumn')
  set colorcolumn=+1
  autocmd FileType sh,cpp,perl,vim,ruby,python,haskell,scheme setlocal textwidth=80
endif

