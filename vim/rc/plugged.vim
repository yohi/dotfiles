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
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
"  Plug 'mattn/vim-lsp-icons'
"  Plug 'hrsh7th/vim-vsnip'
"  Plug 'hrsh7th/vim-vsnip-integ'
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'lighttiger2505/deoplete-vim-lsp'
  " Plug 'deoplete-plugins/deoplete-jedi'
  " Plug 'prabirshrestha/asyncomplete.vim'
  " Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " FZF -----------------------
  "
  "
  " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
  " Plug 'junegunn/fzf.vim'
  " if has('nvim')
  "   Plug 'yuki-ycino/fzf-preview.vim', { 'do': ':FzfPreviewInstall', 'commit': '404f5a7897cdb46ce7398d8aa3087818fe5b78bf' }
  " endif

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }




"  Plug 'wellle/context.vim'
  "Plug '/tyru/caw.vim'

  Plug 'airblade/vim-rooter'

  " LINT
  Plug 'w0rp/ale'

  Plug 'kamykn/spelunker.vim'

  Plug 'rickhowe/diffchar.vim'

  Plug 'cohama/lexima.vim'

  Plug 'rhysd/git-messenger.vim'

  Plug 'vim-scripts/dbext.vim'


  Plug 'lambdalisue/vim-django-support'
  " Plug 'jmcantrell/vim-virtualenv'
  " Plug 'Vimjas/vim-python-pep8-indent'

  Plug 'APZelos/blamer.nvim'

  Plug 'pechorin/any-jump.vim'

  Plug 'RRethy/vim-illuminate'

  Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'nvim-treesitter/nvim-treesitter'

  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-hijack.vim'

  Plug 'lambdalisue/reword.vim'

""""""""""""" 
"""""""""""""[[plugins]]
"""""""""""""repo = 'lambdalisue/vim-django-support'
"""""""""""""on_ft = ['python', 'djangohtml']
"""""""""""""
"""""""""""""[[plugins]]
"""""""""""""repo = 'jmcantrell/vim-virtualenv'
"""""""""""""on_ft = ['python']
"""""""""""""
"""""""""""""[[plugins]]
"""""""""""""repo = 'Vimjas/vim-python-pep8-indent'
"""""""""""""on_ft = ['python']

"Plug 'vim-python/python-syntax'
"let g:python_highlight_all = 1
"
"Plug 'lambdalisue/vim-django-support'
"
"Plug 'klen/python-mode'
"let g:pymode_python = 'python3'
call plug#end()
