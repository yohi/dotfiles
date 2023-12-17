" hook_add {{{
" vim9script

echom("vim-aireline")

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.colnr = '  :'
let g:airline_symbols.readonly = ' '
let g:airline_symbols.linenr = '  :'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = ' '
let g:airline#extensions#nvimlsp#warning_symbol = ' '


let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#virtualenv#ft = ['python', 'markdown']

let g:airline#extensions#whitespace#enabled = 1

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 1

let g:airline#extensions#fzf#enabled = 1

let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

" 'vim-airline/vim-airline-themes
let g:airline_theme='deus'

" nmap <C-n> <Plug>AirlineSelectNextTab
" nmap <C-p> <Plug>AirlineSelectPrevTab

" }}}

