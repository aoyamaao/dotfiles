"==============================================================================
" 1. Vim Initialization
"==============================================================================
" 他のすべての設定やプラグインより先にVimの基本機能を有効化する

" 言語をEnglishに設定
language messages C

" filetype on: ファイルタイプの判別を有効化
" plugin on: プラグインを有効化
" indent on: ファイルタイプに応じたインデント設定
filetype plugin indent on

" シンタックスハイライトを有効化
syntax on

"==============================================================================
" 2. Plugin Management (vim-plug)
"==============================================================================
call plug#begin('~/.vim/plugged')

" --- General Usability ---
Plug 'tpope/vim-vinegar'
Plug 'easymotion/vim-easymotion'
Plug 'mbbill/undotree'

" --- Editing Helpers ---
Plug 'jiangmiao/auto-pairs'

" --- Git Integration ---
Plug 'tpope/vim-fugitive'

" --- Fuzzy Finder ---
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" --- Development & LSP ---
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" --- UI & Theme ---
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }

" --- Utilities ---
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

"==============================================================================
" 3. Plugin Configuration
"==============================================================================

" --- vim-tmux-navigator ---
" プラグインによるデフォルトのキーマッピングを無効化し、自分で定義する
let g:vim_tmux_navigator_no_default_mappings = 1

" --- asyncomplete.vim ---
" 補完ウィンドウを自動で表示する
let g:asyncomplete_auto_popup = 1

" --- vim-lsp ---
" diagnostics(構文エラー等)を有効化し、カーソル位置に情報を表示
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

"==============================================================================
" 4. Editor Behavior
"==============================================================================

" --- UI Settings ---
" 行番号を表示する
set number
" カーソルがある行をハイライトする
set cursorline
" コマンドモードの補完を強化する
set wildmenu
" コマンド補完の挙動を設定する
set wildmode=list:longest,full

" --- Indentation Settings ---
" 改行時に自動でインデントする
set autoindent
" Tabキーをスペースに変換する
set expandtab
" Tabキーの幅をスペース4つ分に設定する
set tabstop=4
" 自動インデントの幅をスペース4つ分に設定する
set shiftwidth=4

" --- コードの折りたたみ機能 ---
" zaで開閉、zRで全展開、zMで全折りたたみ
" set foldmethod=indent
" set foldcolumn=2

" --- File & Backup Settings ---
" インサートモードでのバックスペースの挙動を自然にする
" Indent, End of Line, Startの削除を可能にする
set backspace=2
" 編集履歴をファイルに保存し、Vimを再起動してもUndo可能にする
set undofile
" Undo履歴の保存場所を定義
let s:undodir = expand('~/.vim/undodir')
if !isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
set undodir=~/.vim/undodir
" スワップファイルの保存場所を一箇所にまとめる
set directory=$HOME/.vim/swap//

" --- Clipboard Settings ---
" Vimの無名レジスタとmacOSのシステムクリップボードを同期させる
set clipboard=unnamed

" --- Search Settings ---
" 検索結果をハイライトする
set hlsearch
" 入力中にインクリメンタルに検索する
set incsearch
" 検索時に大文字・小文字を区別しない
set ignorecase
" 検索文字列に大文字が含まれている場合のみ、大文字・小文字を区別する
set smartcase

"==============================================================================
" 5. Key Mappings
"==============================================================================
" LeaderキーをSpaceに設定
let mapleader = " "

" Insertモードから抜ける
inoremap jj <Esc>

" 「保存」「閉じる」「保存して閉じる」のショートカット
nnoremap <Leader>w <Cmd>w<CR>
nnoremap <Leader>q <Cmd>q<CR>
nnoremap <Leader>wq <Cmd>wq<CR>
" UndoTreeを表示
nnoremap <Leader>u :UndotreeToggle<CR>
" ハイライト表示を消去
nnoremap <silent> <Esc><Esc> :noh<CR>

" --- Buffer & Window Navigation ---
" バッファ移動
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
" ターミナルモードのウィンドウ移動
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>
tnoremap <C-h> <C-w><C-h>

" --- vim-tmux-navigator ---
" Vim〜tmuxを移動する
nnoremap <silent> <C-h> :TNavigateLeft<CR>
nnoremap <silent> <C-j> :TNavigateDown<CR>
nnoremap <silent> <C-k> :TNavigateUp<CR>
nnoremap <silent> <C-l> :TNavigateRight<CR>

" --- Editing Helpers ---
" ノーマルモードのまま空行を挿入
nnoremap <silent> <Leader>o o<Esc>
nnoremap <silent> <Leader>O O<Esc>

" --- LSP Mappings ---
" 定義元へジャンプ
nmap <leader>gd <Plug>(lsp-definition)
" 参照元を一覧表示
nmap <leader>gr <Plug>(lsp-references)
" 型情報やドキュメントをホバー表示
nmap <silent> K <Plug>(lsp-hover)
" 変数名などを一括リネーム
nmap <leader>rn <Plug>(lsp-rename)

" LSPによるコードフォーマット
nnoremap <Leader>f <Plug>(lsp-document-format)
" 保存時の自動フォーマット
augroup LspFormatting
  autocmd!
  autocmd BufWritePre *.py LspDocumentFormatSync
augroup END

" --- Auto Completion Mappings ---
" 補完候補をTabで選択・Enterで確定する
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"==============================================================================
" 6. Appearance & Colors
"==============================================================================
" TrueColor有効化 (termguicolors機能を持ってコンパイルされている場合のみ)
if has('termguicolors')
  set termguicolors
endif

" カラーテーマの設定
colorscheme nightfly

" 不可視文字を表示する
set list

" タブ、行末の空白、改行なしスペースの表示文字を設定
set listchars=tab:▸\ ,trail:-,nbsp:¬

"==============================================================================
" 7. Automatic Commands
"==============================================================================
if has('mac')
  let g:original_ime = ''

  function! s:OnFocusGained()
    let g:original_ime = trim(system('im-select'))
    silent! call system('im-select com.apple.keylayout.ABC')
  endfunction

  function! s:OnFocusLost()
    if g:original_ime != '' && g:original_ime != 'com.apple.keylayout.ABC'
      silent! call system('im-select ' . g:original_ime)
    endif
  endfunction
endif

augroup CustomAutoCmds
  autocmd!

  " VimScript用のインデント・タブ設定
  autocmd FileType vim setlocal shiftwidth=2 tabstop=2

  " 全てのファイルタイプで、oやOによるコメントの自動挿入を無効化
  autocmd FileType * setlocal formatoptions-=o

  " Netrwでqを押したときにバッファを閉じる
  autocmd FileType netrw nnoremap <silent> <buffer> q :bdelete<CR>

  if &term =~# '^tmux'
    " フォーカスレポートを有効化するエスケープシーケンス
    let &t_fe = "\<Esc>[?1004h"
    " フォーカスレポートを無効化するエスケープシーケンス
    let &t_fd = "\<Esc>[?1004l"
    " VimがFocusGained/FocusLostとして認識すべきエスケープシーケンスを定義する
    execute "set <FocusGained>=\<Esc>[I"
    execute "set <FocusLost>=\<Esc>[O"
  endif

  " Vimのフォーカス時に英数入力に自動で切り替える
  autocmd FocusGained,WinEnter * call s:OnFocusGained()
  autocmd FocusLost,WinLeave * call s:OnFocusLost()
augroup END

"============================================================================
" FOR DEBUGGING: Input Sniffer
"============================================================================
" This function enters an infinite loop to capture and display every keystroke
" Vim receives. This is for advanced debugging of terminal/tmux interactions.
function! s:DebugInput()
  echom "--- Input Debug Mode Start ---"
  echom "Click on other panes/apps now. Press Ctrl-C to exit this mode."
  while 1
    " Wait for and get a single character (or byte from a sequence)
    let char_code = getchar()

    " Convert the character code to a readable string
    let char_str = (type(char_code) == type(0)) ? nr2char(char_code) : char_code

    " Display all information about the received input
    echom printf("Received -> String: '%s' | Decimal: %s | Hex: 0x%x", char_str, char_code, char_code)
  endwhile
endfunction

" Press <Leader>d to start the input debugger
nnoremap <silent> <leader>d :call <SID>DebugInput()<CR>
