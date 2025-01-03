"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME . '/.cache/dein')
  call dein#begin($HOME . '/.cache/dein')
  call dein#add($HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('AndrewRadev/linediff.vim')
  call dein#add('LeafCage/foldCC')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('github/copilot.vim')
  call dein#add('haya14busa/vim-edgemotion')
  call dein#add('itchyny/lightline.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('lvht/tagbar-markdown')
  call dein#add('machakann/vim-highlightedyank')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('nishigori/increment-activator')
  call dein#add('osyo-manga/vim-anzu')
  call dein#add('preservim/tagbar')
  call dein#add('rhysd/clever-f.vim')
  call dein#add('tanabe/ToggleCase-vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-speeddating')

  call dein#add('tpope/vim-vividchalk')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" LeafCage/foldCC
" @see http://d.hatena.ne.jp/leafcage/20111223/1324705686
set foldtext=FoldCCtext()
set fillchars=vert:\|
let g:foldCCtext_tail = 'printf("   %s[%4d lines  Lv%-2d]%s",
    \ v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'

" @see http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" ctrlpvim/ctrlp.vim
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0 " rg はキャッシュ不要なぐらい速い
let g:ctrlp_prompt_mappings = { 'AcceptSelection("e")':[], 'AcceptSelection("t")': ['<cr>'] } " enter でタブで開く

" haya14busa/vim-edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

" itchyny/lightline.vim
set laststatus=2
let g:lightline = {}
let g:lightline.enable = {
\ 'statusline': 1,
\ 'tabline': 0
\ }
" filename -> relativepath に変更
" anzu 追加
let g:lightline.active = {
\ 'left': [ [ 'mode', 'paste' ],
\           [ 'readonly', 'relativepath', 'modified' ],
\           [ 'anzu' ] ],
\ 'right': [ [ 'lineinfo' ],
\            [ 'percent' ],
\            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
let g:lightline.component_function = { 'anzu': 'anzu#search_status' }

" majutsushi/tagbar
nnoremap <silent> <C-o> :<C-u>TagbarToggle<CR>

let g:tagbar_type_markdown = #{
  \ ctagstype: 'markdown',
  \ kinds: [
    \ 'c:chapter:0:1',
    \ 's:section:0:1',
    \ 'S:subsection:0:1',
    \ 't:subsubsection:0:1',
    \ 'T:l4subsection:0:1',
    \ 'u:l5subsection:0:1',
  \ ],
  \ sro: '""',
  \ kind2scope: #{
    \ c: 'chapter',
    \ s: 'section',
    \ S: 'subsection',
    \ t: 'subsubsection',
    \ T: 'l4subsection',
  \ },
  \ scope2kind: {
    \ 'chapter' : 'c',
    \ 'section' : 's',
    \ 'subsection' : 'S',
    \ 'subsubsection' : 't',
    \ 'l4subsection' : 'T',
  \ },
\ }

" nathanaelkane/vim-indent-guides
let indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233
let g:indent_guides_enable_on_vim_startup = 1

" nishigori/increment-activator
let g:increment_activator_filetype_candidates = {
    \ '_' : [
    \   ['月', '火', '水', '木', '金', '土', '日'],
    \ ],
    \ 'ruby.rspec': [
    \   ['it', 'fit', 'xit'],
    \   ['get', 'post', 'put', 'delete'],
    \ ],
    \ }

" osyo-manga/vim-anzu
nmap n <Plug>(anzu-n)zvzz
nmap N <Plug>(anzu-N)zvzz
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
" @see http://qiita.com/shiena/items/f53959d62085b7980cb5
augroup vim-anzu
  autocmd!
  autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

" rhysd/clever-f.vim
let g:clever_f_fix_key_direction = 1

" tanabe/ToggleCase-vim
" @see http://blog.kaihatsubu.com/?p=2049
nnoremap <silent> K :<C-u>call ToggleCase()<CR>

" =====================================================================

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
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:\
set ambiwidth=double
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set clipboard=unnamed
set wildmenu
set wildmode=list:longest
set backspace=start,indent,eol
set display=lastline
set nrformats=bin,hex

" 表示行単位の移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

nnoremap Y y$

" 選択範囲を上下移動
vnoremap <DOWN> :m'>+<CR>gv=gv
vnoremap <UP> :m-2<CR>gv=gv

" window 移動
nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l

" tab 移動
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

" folding
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" 誤爆してウザいので
nnoremap q: <NOP>

" Esc 2連打で nohlsearch
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>

" テキストの整形方法(改行時の自動コメントアウト等)を調整
autocmd FileType * setlocal formatoptions=tcqnlmMj

" Remove trailing spaces
function! RTrim()
  let s:cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", s:cursor)
endfunction

" ripgrep で grep する
" http://hogeai.hatenablog.com/entry/2018/03/04/201744
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" grep したら copen
autocmd QuickfixCmdPost grep copen

" ======================================================================
" filetype
" ----------------------------------------------------------------------
" perl は 4 スペ
autocmd FileType perl setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup filetypedetect
    autocmd! BufNewFile,BufRead *.t,*.psgi,cpanfile setf perl
augroup END

" .pm ファイルを作ったときのテンプレート
function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    execute ':normal a' . 'package ' . path . ';'
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, '')
    call append(4, '')
    call append(5, '')
    call append(6, '1;')
    call cursor(5, 0)
    echomsg path
endfunction

function! s:pl_template()
    execute ':normal a' . 'use v5.20;'
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, 'use utf8;')
    call append(4, '')
    call append(5, '')
    call cursor(6, 0)
endfunction
autocmd BufNewFile *.pm call s:pm_template()
autocmd BufNewFile *.pl call s:pl_template()

let perl_fold=1

" ======================================================================
" color
" ----------------------------------------------------------------------
set t_Co=256
colorscheme vividchalk
set background=dark
hi Search term=reverse ctermfg=black ctermbg=brown

" カーソル行を強調
set cursorline
highlight CursorLine ctermbg=234 cterm=NONE

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue
match ZenkakuSpace /　/

" ======================================================================
" load local setting
" ----------------------------------------------------------------------
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
