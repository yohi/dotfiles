" https://github.qitoy.dev/post/dein-to-dpp/

augroup vimrc
  autocmd!
augroup END

" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible
const s:cache_dir = expand('~/.cache')

function InitPlugin(plugin)
    let dir = s:cache_dir .. '/dpp/repos/github.com/' .. a:plugin
    if !(dir->isdirectory())
        execute '! git clone https://github.com/' .. a:plugin dir
    endif
    execute 'set runtimepath^=' .. dir
endfunction

call InitPlugin('Shougo/dpp.vim')


if dpp#min#load_state(s:cache_dir .. '/dpp')
    echohl WarningMsg | echohl 'begin make state' | echohl None

    for s:plugin in [
    \ 'Shougo/dpp-ext-installer',
    \ 'Shougo/dpp-ext-toml',
    \ 'Shougo/dpp-ext-lazy',
    \ 'Shougo/dpp-protocol-git',
    \ 'vim-denops/denops.vim',
    \ 'Shougo/dpp-ext-installer',
    \]
        call InitPlugin(s:plugin)
    endfor

    runtime! plugin/denops.vim

    autocmd vimrc User DenopsReady
    \ call dpp#make_state(s_cache_dir .. '/dpp', '~/dotfiles/vim/dpp/dpp.ts'->expand())

    autocmd vimrc User Dpp:makeStatePost
    \ echohl WarningMsg | echomsg 'end make state' | echohl None
else
    autocmd vimrc BufWritePost *.lua,*.vim,*.toml,*.ts,vimrc,.vimrc
    \ call dpp#check_files()
endif


""""" " Set dpp base path (required)
""""" const s:dpp_base = s:cache_dir . '/dpp/'
""""" 
""""" const s:repo_dir = s:dpp_base . 'repos/'
""""" 
""""" const s:dpp_repo = 'github.com/Shougo/dpp.vim'
""""" const s:denops_repo = 'github.com/vim-denops/denops.vim'
""""" const s:ext_toml_repo = 'github.com/Shougo/dpp-ext-toml'
""""" const s:ext_lazy_repo = 'github.com/Shougo/dpp-ext-lazy'
""""" const s:ext_installer_repo = 'github.com/Shougo/dpp-ext-installer'
""""" const s:protocol_git_repo = 'github.com/Shougo/dpp-protocol-git'
""""" 
""""" " Set dpp source path (required)
""""" " NOTE: The plugins must be cloned before.
""""" const s:dpp_src = s:repo_dir . s:dpp_repo
""""" const s:denops_src = s:repo_dir . s:denops_repo
""""" const s:ext_toml_src = s:repo_dir . s:ext_toml_repo
""""" const s:ext_lazy_src = s:repo_dir . s:ext_lazy_repo
""""" const s:ext_installer_src = s:repo_dir . s:ext_installer_repo
""""" const s:protocol_git_src = s:repo_dir . s:protocol_git_repo
""""" 
""""" if !(s:cache_dir->isdirectory())
"""""     call mkdir(s:cache_dir, 'p)
""""" endif
""""" 
""""" if &runtimepath !~# '/dpp.vim'
"""""     " let s:dir = 'dpp.vim'->fnamemodify(':p')
"""""     " if !(s:dir->isdirectory())
"""""     "   let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
"""""     "   if !(s:dir->isdirectory())
"""""     "     execute '!git clone https://github.com/Shougo/dein.vim' s:dir
"""""     "   endif
"""""     " endif
"""""     " execute 'set runtimepath^=' .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
"""""     if !(s:dpp_src->isdirectory())
"""""         execute '!git clone https://' . s:dpp_repo s:dpp_src
"""""         execute '!git clone https://' . s:denops_repo s:denops_src
"""""         execute '!git clone https://' . s:ext_toml_repo s:ext_toml_src
"""""         execute '!git clone https://' . s:ext_lazy_repo s:ext_lazy_src
"""""         execute '!git clone https://' . s:ext_installer_repo s:ext_installer_src
"""""         execute '!git clone https://' . s:protocol_git_repo s:protocol_git_src
"""""     endif
""""" endif
""""" 
""""" " Set dpp runtime path (required)
""""" execute 'set runtimepath^=' .. s:dpp_src
""""" execute 'set runtimepath^=' .. s:denops_src
""""" execute 'set runtimepath^=' .. s:ext_toml_src
""""" execute 'set runtimepath^=' .. s:ext_lazy_src
""""" execute 'set runtimepath^=' .. s:ext_installer_src
""""" execute 'set runtimepath^=' .. s:protocol_git_src
""""" 
""""" " if s:dpp_base->dpp#min#load_state()
""""" " if dpp#min#load_state(s:dpp_base)
""""" "   " NOTE: dpp#make_state() requires denops.vim
""""" "   " NOTE: denops.vim and dpp plugins are must be added
""""" "   execute 'set runtimepath^=' .. s:denops_src
""""" "   execute 'set runtimepath^=' .. s:ext_toml_src
""""" "   execute 'set runtimepath^=' .. s:ext_lazy_src
""""" "   execute 'set runtimepath^=' .. s:ext_installer_src
""""" "   execute 'set runtimepath^=' .. s:protocol_git_src
""""" "
""""" "   autocmd User DenopsReady
""""" "   \ : echohl WarningMsg
""""" "   \ | echomsg 'dpp load_state() is failed'
""""" "   \ | echohl NONE
""""" "   \ | call dpp#make_state(s:dpp_base, '~/dotfiles/vim/dpp/dpp.ts')
""""" " endif
""""" 
""""" if dpp#min#load_state(s:dpp_base)
"""""   " NOTE: dpp#make_state() requires denops.vim
"""""   " execute 'set runtimepath^=' .. s:denops_src
"""""   autocmd User DenopsReady
"""""   \ call dpp#make_state(s:dpp_base, '~/dotfiles/vim/dpp/dpp.ts')
""""" endif
""""" 
""""" " autocmd User Dpp:makeStatePost
""""" "       \ : echohl WarningMsg
""""" "       \ | echomsg 'dpp make_state() is done'
""""" "       \ | echohl NONE
""""" 
""""" " Attempt to determine the type of a file based on its name and
""""" " possibly its " contents. Use this to allow intelligent
""""" " auto-indenting " for each filetype, and for plugins that are
""""" " filetype specific.
""""" filetype indent plugin on
""""" 
""""" " Enable syntax highlighting
""""" if has('syntax')
"""""   syntax on
"""""   " TODO
"""""   colorscheme codedark
"""""   highlight LspDiagnosticsSignError ctermbg=None cterm=underline ctermfg=Red
"""""   highlight LspDiagnosticsSignWarn  ctermbg=None cterm=underline ctermfg=Yellow
"""""   highlight LspDiagnosticsSignHint  ctermbg=None cterm=underline ctermfg=LightBlue
"""""   highlight LspDiagnosticsSignInfo  ctermbg=None cterm=underline ctermfg=White
"""""   highlight CocInlayHint ctermbg=18 ctermfg=112 guibg=#cceeee guifg=#004400 cterm=italic gui=italic
""""" endif
