" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

const s:cache_dir = expand('~/.cache')

" Set dpp base path (required)
const s:dpp_base = s:cache_dir . '/dpp/repos/'

const s:dpp_repo = 'github.com/Shougo/dpp.vim'
const s:denops_repo = 'github.com/vim-denops/denops.vim'
const s:ext_toml_repo = 'github.com/Shougo/dpp-ext-toml'
const s:ext_lazy_repo = 'github.com/Shougo/dpp-ext-lazy'
const s:ext_installer_repo = 'github.com/Shougo/dpp-ext-installer'

" Set dpp source path (required)
" NOTE: The plugins must be cloned before.
const s:dpp_src = s:dpp_base . s:dpp_repo
const s:denops_src = s:dpp_base . s:denops_repo
const s:ext_toml_src = s:dpp_base . s:ext_toml_repo
const s:ext_lazy_src = s:dpp_base . s:ext_lazy_repo
const s:ext_installer_src = s:dpp_base . s:ext_installer_repo

if !(s:cache_dir->isdirectory())
    call mkdir(s:cache_dir, 'p)
endif

if &runtimepath !~# '/dpp.vim'
    " let s:dir = 'dpp.vim'->fnamemodify(':p')
    " if !(s:dir->isdirectory())
    "   let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    "   if !(s:dir->isdirectory())
    "     execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    "   endif
    " endif
    " execute 'set runtimepath^=' .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
    if !(s:dpp_src->isdirectory())
        execute '!git clone https://' . s:dpp_repo s:dpp_src
        execute '!git clone https://' . s:denops_repo s:denops_src
        execute '!git clone https://' . s:ext_toml_repo s:ext_toml_src
        execute '!git clone https://' . s:ext_lazy_repo s:ext_lazy_src
        execute '!git clone https://' . s:ext_installer_repo s:ext_installer_src
    endif
endif

" Set dpp runtime path (required)
execute 'set runtimepath^=' .. s:dpp_src

if s:dpp_base->dpp#min#load_state()
  " NOTE: dpp#make_state() requires denops.vim
  " NOTE: denops.vim and dpp plugins are must be added
  execute 'set runtimepath^=' .. s:denops_src
  execute 'set runtimepath^=' .. s:ext_installer_src

  autocmd User DenopsReady
  \ : echohl WarningMsg
  \ | echomsg 'dpp load_state() is failed'
  \ | echohl NONE
  \ | call dpp#make_state(s:dpp_base, '{TypeScript config file path}')
endif

autocmd User Dpp:makeStatePost
      \ : echohl WarningMsg
      \ | echomsg 'dpp make_state() is done'
      \ | echohl NONE

" Attempt to determine the type of a file based on its name and
" possibly its " contents. Use this to allow intelligent
" auto-indenting " for each filetype, and for plugins that are
" filetype specific.
filetype indent plugin on

" Enable syntax highlighting
if has('syntax')
  syntax on
endif
