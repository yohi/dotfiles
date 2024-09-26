" hook_add {{{
" vim9script

" You must set the default ui.
" NOTE: native ui
" https://github.com/Shougo/ddc-ui-native
call ddc#custom#patch_global('ui', 'native')

"" lsp =======================================

call ddc#custom#patch_global('sources', [
    \ 'lsp',
    \ 'around',
    \ 'file',
    \ ])

call ddc#custom#patch_global('sourceOptions', #{
    \ _: #{
    \   matchers: ['matcher_head'],
    \   sorters: ['sorter_rank'],
    \   converters: ['converter_remove_overlap']
    \ },
    \ })

call ddc#custom#patch_global(#{
      \ sourceOptions: #{
      \   lsp: #{
      \     dup: 'keep',
      \     keywordPattern: '\k+',
      \     sorters: ['sorter_lsp-kind']
      \   },
      \ },
      \ sourceParams: #{
      \   lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body) }),
      \     enableResolveItem: v:true,
      \     enableAdditionalTextEdit: v:true,
      \     confirmBehavior: 'replace',
      \   },
      \ },
      \})

call ddc#custom#patch_global('sourceOptions', #{
    \ around: #{
    \   mark: 'Arround',
    \ },
    \ })

"""""" around =======================================
""""" Use around source.
""""" https://github.com/Shougo/ddc-source-around
""""
""""call ddc#custom#patch_global('sources', [
""""    \ 'around',
""""    \ ])
""""
""""call ddc#custom#patch_global('sourceOptions', #{
""""    \ around: #{
""""    \   mark: 'Arround',
""""    \ },
""""    \ })
""""
"""""" vsnip =======================================
""""
""""call ddc#custom#patch_global('sources', [
""""    \ 'vsnip',
""""    \ ])
""""
""""call ddc#custom#patch_global('sourceOptions', #{
""""    \ vsnip: #{
""""    \   mark: 'vsnip',
""""    \ },
""""    \ })
""""
"""""" file =======================================
""""
""""call ddc#custom#patch_global('sources', [
""""    \ 'file',
""""    \ ])
""""
""""
""""" Use matcher_head and sorter_rank. =============
""""" https://github.com/Shougo/ddc-matcher_head
""""" https://github.com/Shougo/ddc-sorter_rank
""""call ddc#custom#patch_global('sourceOptions', #{
""""    \ _: #{
""""    \   matchers: ['matcher_head'],
""""    \   sorters: ['sorter_rank'],
""""    \   converters: ['converter_remove_overlap']
""""    \ },
""""    \ })
""""
call ddc#enable()
lua require('notify')('ddc#enable!!')



" vim-vsnip
imap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
smap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
imap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
smap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
let g:vsnip_filetypes = {}


" }}}


" hook_source {{{
" vim9script

" denops-popup-preview
call popup_preview#enable()

" denops-signature_help
call signature_help#enable()

" if you use with vim-lsp, disable vim-lsp's signature help feature
let g:lsp_signature_help_enabled = 0

" }}}
