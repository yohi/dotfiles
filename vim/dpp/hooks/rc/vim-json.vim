" hook_add {{{
" vim9script

let g:vim_json_syntax_conceal = 0
let g:indentLine_concealcursor="nc"
au! BufAdd,BufRead,BufNew,BufEnter *.json let g:indentLine_conceallevel=1
au! BufLeave,BufUnload,BufDelete,BufHidden *.json let g:indentLine_conceallevel=2

" }}}
