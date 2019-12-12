" PLUGGED.VIM =================================================

if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}

  " UI系 ------------------------

  " カラースキーマ
  Plug 'tomasiser/vim-code-dark'

  " 全角スペースをホワイトに表示
  Plug 'thinca/vim-zenspace'

  " ステータスバー
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'Yggdroot/indentLine'

  " GIT系 ----------------------

  Plug 'tpope/vim-fugitive'

  Plug 'airblade/vim-gitgutter'

  " ---------------------------
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '/bin/sh ./install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'airblade/vim-rooter'

  " LINT
  Plug 'w0rp/ale'

  Plug 'kamykn/spelunker.vim'

  Plug 'rickhowe/diffchar.vim'

  Plug 'cohama/lexima.vim'

  Plug 'rhysd/git-messenger.vim'

  Plug 'vim-scripts/dbext.vim'


"Plug 'vim-python/python-syntax'
"let g:python_highlight_all = 1
"
"Plug 'lambdalisue/vim-django-support'
"
"Plug 'klen/python-mode'
"let g:pymode_python = 'python3'
call plug#end()
