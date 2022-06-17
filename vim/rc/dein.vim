if has('vim_starting')
    let s:dein_dir = expand($HOME . '/.cache/dein')
    if !isdirectory(s:dein_dir)
        echo 'install dein.vim...'
        call system('mkdir -p ' . s:dein_dir)
        call system('curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh -s ' . s:dein_dir)
    endif
endif

"dein Scripts-----------------------------

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('$HOME/.cache/dein')
    " Required:
    call dein#begin('$HOME/.cache/dein')

    let s:toml = expand($HOME . '/.vim/rc/dein.toml')
    let s:toml_lazy = expand($HOME . '/.vim/rc/dein_lazy.toml')

    call dein#load_toml(s:toml, { 'lazy': 0 })
    call dein#load_toml(s:toml_lazy, { 'lazy': 1 })

    " Required:
    call dein#end()

    call dein#save_state()

endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" TODO
colorscheme codedark
