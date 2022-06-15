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
" set nobackup
" バックアップ先の設定
set backup
set backupdir=~/dotfiles/vim/backup
set backupext=.bk

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
set shiftwidth=4

" タブが対応する半角スペースの数
set tabstop=4

" 連続した空白に対してタブやバックスペースでカーソルが動く幅
set softtabstop=4

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" IMDISABLE
set imdisable

" xで削除した時はヤンクしない
"vnoremap x "_x
"nnoremap x "_x


augroup MyVariousAutoCommand
    autocmd!
    " 自動改行しない
    autocmd FileType * setl textwidth=0
    " 改行時にコメントアウト記号を自動挿入しない
    autocmd FileType * setl formatoptions-=ro
    " ファイルのディレクトリに移動
    autocmd BufNewFile,BufRead,BufEnter * execute ':lcd ' . expand('%:p:h')
augroup END

" 特定を
set synmaxcol=200

"
augroup vimrc-highlight
  au!
  au Syntax json if 1000 < col('$') | syntax off | endif
augroup END





let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0




" let g:python_dir = '~/.vim/python'
" let g:python_venv_dir = g:python_dir . '/.venv'
" if has('vim_starting')
"   if !isdirectory(expand(g:python_venv_dir))
"     echo 'create venv ...'
"     call system('python3 -m venv ' . g:python_venv_dir)
"     echo 'pip install -r requirements.txt'
"     " call system('source ' . g:python_venv_dir . '/bin/active' && 'pip install -r ' . s:python_dir . '/requirements.txt' )
"     call system(g:python_venv_dir . '/bin/python -m pip install -r ' . g:python_dir . '/requirements.txt')
"     call system('echo "hello world!"')
"   endif
" endif
" 
" let g:python_host_prog = g:python_venv_dir . '/bin/python'
" let g:python3_host_prog = g:python_host_prog
" let $PATH = g:python_venv_dir . '/bin:' . $PATH

if has('nvim') && !filereadable(expand('~/.vim'))
  let s:python3 = system('which python3')
  if strlen(s:python3) != 0
    let s:python3_dir = $HOME . '/.vim/python3'
    if ! isdirectory(s:python3_dir)
      echo 'create venv ...'
      call system('python3 -m venv ' . s:python3_dir)
      echo 'pip install -r requirements.txt'
      call system('source ' . s:python3_dir . '/bin/activate && pip install -r ~/.vim/requirements.txt')
    endif
    let g:python3_host_prog = s:python3_dir . '/bin/python'
    let $PATH = s:python3_dir . '/bin:' . $PATH
  endif
endif


" let g:pip_host_prog = g:python_host_prog . ' -m pip'
" let g:pip3_host_prog = g:pip_host_prog
"let g:pip_host_prog = '/home/linuxbrew/.linuxbrew/bin/pip3'
"let g:pip3_host_prog = '/home/linuxbrew/.linuxbrew/bin/pip3'


inoremap <C-[> <C-[>:w<CR>
