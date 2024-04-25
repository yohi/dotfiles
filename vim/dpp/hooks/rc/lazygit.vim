" hook_add {{{
" vim9script

" transparency of floating window
let g:lazygit_floating_window_winblend = 0

" scaling factor for floating window
let g:lazygit_floating_window_scaling_factor = 0.9

" customize lazygit popup window corner characters
let g:lazygit_floating_window_border_chars = ['╭', '╮', '╰', '╯'] 

" fallback to 0 if neovim-remote is not installed
let g:lazygit_use_neovim_remote = 1 

" setup mapping to call :LazyGit
nnoremap <silent> lg :LazyGit<CR>

" }}}
