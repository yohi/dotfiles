" BASIC.VIM ================================================

" VIとの互換性をとらない
set nocompatible

" VIMが通常使う文字エンコーディング
set encoding=utf8

" 自動認識する文字エンコーディングの優先順一覧
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16,utf-16le

" VIMが通常使用する改行コード
set fileformat=unix

" 自動認識する改行コードの優先順一覧
set fileformats=unix,dos,mac

" バックアップファイルを作成しない
set nobackup

" スワップファイルを作成しない
set noswapfile

" undoファイルを作成しない
set noundofile

" ファイルが外部で変更された時は読みなおす
set autoread

" バッファの編集を保持したまま、別バッファの展開を可能にする
set hidden

" コマンドと検索パターンの履歴数
set history=1000

" コマンド確定時間
set timeout
set timeoutlen=500

" Windowsのパスをスラッシュ区切りに
set shellslash

" クリップボード共有
set clipboard+=unnamedplus

" バックスペース有効
set backspace=indent,eol,start

" [%]で移動する対応括弧
set matchpairs=(:),{:},[:],<:>

" カーソルを行頭末で停止させない
set whichwrap=b,s,h,l,<,>,[,]

" タブの代わりに半角スペースを使用
set expandtab

" オートインデント有効
set autoindent

" 高度なオートインデント有効
set smartindent

" 行頭では[shiftwidth]、それ以外では[tabstop]の数を適用
set smarttab

" インデントが対応する半角スペースの数
set shiftwidth=2

" タブが対応する半角スペースの数
set tabstop=2

" 連続した空白に対してタブやバックスペースでカーソルが動く幅
set softtabstop=2

" xで削除した時はヤンクしない
vnoremap x "_x
nnoremap x "_x


augroup MyVariousAutoCommand
    autocmd!
    " 自動改行しない
    autocmd FileType * setl textwidth=0
    " 改行時にコメントアウト記号を自動挿入しない
    autocmd FileType * setl formatoptions-=ro
    " ファイルのディレクトリに移動
    autocmd BufNewFile,BufRead,BufEnter * execute ':lcd ' . expand('%:p:h')
augroup END
