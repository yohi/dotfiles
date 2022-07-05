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

" let g:dein#auto_recache=1

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('$HOME/.cache/dein')
    " Required:
    call dein#begin('$HOME/.cache/dein')

    let s:toml = expand($HOME . '/.vim/rc/dein.toml')
    let s:toml_lazy = expand($HOME . '/.vim/rc/dein_lazy.toml')

    echo s:toml_lazy

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
  echo 'dein install...'
  call dein#install()
  call dein#remote_plugins()
endif

"End dein Scripts-------------------------

" TODO
colorscheme codedark
highlight LspDiagnosticsSignError ctermbg=None cterm=underline ctermfg=Red
highlight LspDiagnosticsSignWarn  ctermbg=None cterm=underline ctermfg=Yellow
highlight LspDiagnosticsSignHint  ctermbg=None cterm=underline ctermfg=LightBlue
highlight LspDiagnosticsSignInfo  ctermbg=None cterm=underline ctermfg=White
