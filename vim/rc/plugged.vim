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
  let g:zenspace#default_mode = 'on'
  augroup vimrc-highlight
    autocmd!
    autocmd ColorScheme * highlight ZenSpace ctermbg=White guibg=White
  augroup END

  " ステータスバー
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_theme='deus'

  Plug 'Yggdroot/indentLine'
  let g:indentLine_char = '¦'

  " GIT系 ----------------------

  Plug 'tpope/vim-fugitive'

  Plug 'airblade/vim-gitgutter'

  " ---------------------------

  " LSP
"""""""""""""""""""  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }
"""""""""""""""""""  Plug 'junegunn/fzf'
"""""""""""""""""""  let g:LanguageClient_diagnosticsEnable = 0
"""""""""""""""""""
"""""""""""""""""""  Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
"""""""""""""""""""  " assuming you're using vim-plug: https://github.com/junegunn/vim-plug
"""""""""""""""""""  Plug 'ncm2/ncm2'
"""""""""""""""""""  Plug 'roxma/nvim-yarp'
"""""""""""""""""""
"""""""""""""""""""  " enable ncm2 for all buffers
"""""""""""""""""""  autocmd BufEnter * call ncm2#enable_for_buffer()
"""""""""""""""""""
"""""""""""""""""""  " IMPORTANT: :help Ncm2PopupOpen for more information
"""""""""""""""""""  set completeopt=noinsert,menuone,noselect
"""""""""""""""""""
"""""""""""""""""""  " NOTE: you need to install completion sources to get completions. Check
"""""""""""""""""""  " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
"""""""""""""""""""  Plug 'ncm2/ncm2-bufword'
"""""""""""""""""""  Plug 'ncm2/ncm2-path'
  "Plug 'neoclide/coc.nvim', {'tag': '*', 'do': '/bin/sh ./install.sh'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': '/bin/sh ./install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'airblade/vim-rooter'



  " LINT
  Plug 'w0rp/ale'
  let g:ale_sign_column_always = 1

  Plug 'kamykn/spelunker.vim'
  set nospell

"  " 補完
"  if has('nvim')
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  else
"    Plug 'Shougo/deoplete.nvim'
"    Plug 'roxma/nvim-yarp'
"    Plug 'roxma/vim-hug-neovim-rpc'
"  endif
"  let g:deoplete#enable_at_startup = 1
"
"  Plug 'Shougo/neosnippet.vim'
"  Plug 'Shougo/neosnippet-snippets'

  if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  Plug 'rickhowe/diffchar.vim'

"macのみ
"  Plug 'callmekohei/switcher.nvim', { 'do': 'UpdateRemotePlugins' }

  Plug 'cohama/lexima.vim'

  Plug 'rhysd/git-messenger.vim'

  Plug 'vim-scripts/dbext.vim'


  Plug 'vim-python/python-syntax'
  let g:python_highlight_all = 1

  Plug 'lambdalisue/vim-django-support'


  Plug 'klen/python-mode'
  let g:pymode_python = 'python3'


call plug#end()

