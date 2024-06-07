" hook_add {{{
" vim9script

echom "ale.vim: hook_add"

let g:ale_linters = {
\   'python': ['cspell'],
\}

" }}}
