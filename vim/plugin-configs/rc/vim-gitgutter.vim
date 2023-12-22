" hook_add {{{
" vim9script

set updatetime=100
let g:gitgutter_async = 1
" let g:gitgutter_sign_added = '✚'
" let g:gitgutter_sign_modified = '➡'
" let g:gitgutter_sign_removed = '✖'
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow
nmap <C-g>s <Plug>(GitGutterPreviewHunk)
nmap <C-g>j <Plug>(GitGutterNextHunk)
nmap <C-g>k <Plug>(GitGutterPrevHunk)
nmap <C-g>u <Plug>(GitGutterUndoHunk)
nmap <C-g>h :GitGutterLineHighlightsToggle<CR>

" }}}
