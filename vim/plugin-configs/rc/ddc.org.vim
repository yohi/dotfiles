" hook_add {{{
" vim9script

" Customize global settings

" You must set the default ui.
" NOTE: native ui
" https://github.com/Shougo/ddc-ui-native
call ddc#custom#patch_global('ui', 'native')

" Use around source.
" https://github.com/Shougo/ddc-source-around
call ddc#custom#patch_global('sources', [
    \ 'lsp',
    \ 'vsnip',
    \ 'around',
    \ 'file',
    \ ])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', #{
    \ _: #{
    \   matchers: ['matcher_head'],
    \   sorters: ['sorter_rank'],
    \   converters: ['converter_remove_overlap']
    \ },
    \ })

"" lsp =======================================

call ddc#custom#patch_global('sourceOptions', #{
    \   lsp: #{
    \     mark: 'lsp',
    \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
    \   },
    \ })

call ddc#custom#patch_global('sourceOptions', #{
    \ lsp: #{
    \   dup: 'keep',
    \   keywordPattern: '\k+',
    \   sorters: ['sorter_lsp-kind']
    \ },
    \ })

call ddc#custom#patch_global('sourceParams', #{
    \   lsp: #{
    \     snippetEngine: denops#callback#register({
    \           body -> vsnip#anonymous(body)
    \     }),
    \     enableResolveItem: v:true,
    \     enableAdditionalTextEdit: v:true,
    \   }
    \ })

"" around =======================================

call ddc#custom#patch_global('sourceOptions', #{
    \ around: #{
    \   mark: 'Arround',
    \ },
    \ })

"" vsnip =======================================

call ddc#custom#patch_global('sourceOptions', #{
    \ vsnip: #{
    \   mark: 'vsnip',
    \ },
    \ })

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

call ddc#enable()

function! MyNotify()
  lua vim.notify("ddc#enable", "success")
endfunction

" ファンクション「SendNotification」を呼び出す
call MyNotify()

echom('vim-vsnip')
imap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
smap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
imap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
smap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
let g:vsnip_filetypes = {}


" }}}


" hook_source {{{
" vim9script

echom('denops-popup-preview')
call popup_preview#enable()

echom('denops-signature_help')
call signature_help#enable()

" if you use with vim-lsp, disable vim-lsp's signature help feature
let g:lsp_signature_help_enabled = 0

" }}}
