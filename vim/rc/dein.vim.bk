" " set up the dein.vim directory
" let s:dein_dir = expand('~/.cache/dein')
" let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" 
" " automatic installation of dein.vim
" if !isdirectory(s:dein_repo_dir)
"   execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
" endif
" execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^=' .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif

let s:dein_base = $CACHE .. '/dein'
let s:rc_dir = expand('~/.vim/rc')

if dein#load_state(s:dein_base)
    " Required:
    call dein#begin(s:dein_base)

    let s:toml = s:rc_dir . '/dein.toml'
    let s:toml_treesitter = s:rc_dir . '/dein_treesitter.toml'
    let s:toml_lsp = s:rc_dir . '/dein_lsp.toml'
    let s:toml_lazy = s:rc_dir . '/dein_lazy.toml'
    let s:toml_lazy_ddc = s:rc_dir . '/dein_lazy_ddc.toml'

    call dein#load_toml(s:toml, { 'lazy': 0 })
    call dein#load_toml(s:toml_treesitter, { 'lazy': 0 })
    call dein#load_toml(s:toml_lsp, { 'lazy': 0 })
    call dein#load_toml(s:toml_lazy, { 'lazy': 1 })
    call dein#load_toml(s:toml_lazy_ddc, { 'lazy': 1 })

    " Required:
    call dein#end()

    call dein#save_state()

endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  echom 'dein install...'
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
highlight CocInlayHint ctermbg=18 ctermfg=112 guibg=#cceeee guifg=#004400 cterm=italic gui=italic
