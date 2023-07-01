" pum.vim

" mapping
" inoremap <silent><expr> <TAB>
"     \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
"     \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"     \ '<TAB>' : ddc#manual_complete()
" inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
" inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
" inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
" inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
" inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

" command line compolete event

" call ddc#custom#patch_global('autoCompleteEvents', [
"     \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
"     \ 'CmdlineEnter', 'CmdlineChanged',
"     \ ])
" 
" nnoremap :       <Cmd>call CommandlinePre()<CR>:
" 
" function! CommandlinePre() abort
"     " Note: It disables default command line completion!
"     cnoremap <expr> <Tab>
"         \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
"         \ ddc#manual_complete()
"     cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
"     cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
"     cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
" 
"     " Overwrite sources
"     if !exists('b:prev_buffer_config')
"         let b:prev_buffer_config = ddc#custom#get_buffer()
"     endif
"     call ddc#custom#patch_buffer('sources',
"         \ ['cmdline', 'cmdline-history', 'around'])
" 
"     autocmd User DDCCmdlineLeave ++once call CommandlinePost()
"     autocmd InsertEnter <buffer> ++once call CommandlinePost()
" 
"     " Enable command line completion
"     call ddc#enable_cmdline_completion()
" endfunction
" function! CommandlinePost() abort
"     cunmap <Tab>
"     cunmap <S-Tab>
"     cunmap <C-y>
"     cunmap <C-e>
" 
"     " Restore sources
"     if exists('b:prev_buffer_config')
"         call ddc#custom#set_buffer(b:prev_buffer_config)
"         unlet b:prev_buffer_config
"     else
"         call ddc#custom#set_buffer({})
"     endif
" endfunction


" ddc.vim

" Customize global settings

" You must set the default ui.
" NOTE: native ui
" https://github.com/Shougo/ddc-ui-native
call ddc#custom#patch_global('ui', 'native')

" Use around source.
" https://github.com/Shougo/ddc-source-around
call ddc#custom#patch_global('sources', [
    \ 'around',
    \ 'nvim-lsp',
    \ 'file',
    \ 'vsnip'
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

" Change source options
call ddc#custom#patch_global('sourceOptions', #{
    \ around: #{
    \   mark: 'Arround',
    \ },
    \ })

call ddc#custom#patch_global('sourceOptions', #{
    \ nvim-lsp: #{
    \   mark: 'lsp',
    \   matchers: ['matcher_head'],
    \   forceCompletionPattern: '\.|:|->|"\w+/*',
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
