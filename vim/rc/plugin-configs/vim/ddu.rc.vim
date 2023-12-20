""""" call ddu#custom#patch_global({
""""" \   'ui': 'ff',
""""" \   'sourceOptions': {
""""" \       '_': {
""""" \           'matchers': ['matcher_substring'],
""""" \       },
""""" \   },
""""" \   'kindOptions': {
""""" \       'file': {
""""" \         'defaultAction': 'open',
""""" \       },
""""" \   },
""""" \   'uiParams': {
""""" \       'ff': {
""""" \           'autoResize': v:true,
""""" \           'split': 'floating',
""""" \           'startFilter': v:true,
""""" \           'filterSplitDirection': 'floating',
""""" \           'filterFloatingPosition': 'top',
""""" \           'highlights': {'floating': 'NormalFloat', 'prompt': 'Special'},
""""" \           'previewFloating': v:true,
""""" \           'previewHeight': 100,
""""" \           'previewWidth': 400,
""""" \           'prompt': '> ',
""""" \       }
""""" \   },
""""" \ })
""""" 
""""" autocmd FileType ddu-ff call s:ddu_my_settings()
""""" function! s:ddu_my_settings() abort
"""""     nnoremap <buffer><silent> <CR>
"""""     \   <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
"""""     nnoremap <buffer><silent> <Space>
"""""     \   <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
"""""     nnoremap <buffer><silent> i
"""""     \   <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
"""""     nnoremap <buffer><silent> q
"""""     \   <Cmd>call ddu#ui#ff#do_action('quit')<CR>
""""" endfunction
""""" 
""""" autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
""""" function! s:ddu_filter_my_settings() abort
"""""     inoremap <buffer> <C-j>
"""""     \ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)")<CR>
"""""     inoremap <buffer> <C-k>
"""""     \ <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)")<CR>
"""""     inoremap <buffer><silent> <CR>
"""""     \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"""""     inoremap <buffer><silent> q
"""""     \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"""""     inoremap <buffer><silent> ^[
"""""     \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"""""     nnoremap <buffer><silent> <CR>
"""""     \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"""""     nnoremap <buffer><silent> q
"""""     \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"""""     nnoremap <buffer><silent> ^[
"""""     \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"""""     inoremap <buffer> <CR>
"""""     \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
""""" endfunction
