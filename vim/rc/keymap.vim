" KEYMAP.VIM

" Normal Mode ------------------------------------------------------------------
" [;]を[:]に変換
nnoremap ; :

" 分割画面移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 検索結果ハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR>

" 縦分割
nnoremap <LEADER>v :vsp<CR>:ls<CR>:buf

" 横分割
nnoremap <LEADER>s :split<CR>:ls<CR>buf

" ファイラ表示切替
nnoremap <LEADER>f :<C-u>NERDTreeToggle<CR>

" すべて選択
nnoremap <C-a> ggVG

" カーソルを先頭に移動
"nnoremap

" Normal ModeでもEnterで改行
nnoremap <CR> o<ESC>

"nnoremap <C-p> :<C-u>execute
"      \ 'Unite'
"      \ '-start-insert'
"      \ 'buffer file_mru'
"      \ 'file:'.fnameescape(expand('%:p:h'))
"      \ 'file_rec:!:'.fnameescape(expand('%:p:h'))
"      \ <CR>

" F5 : バッファ一覧表示と移動先番号入力待ち
nnoremap <F5> :ls<CR>:buf
" F6 : バッファを削除
nnoremap <F6> :bw<CR>
" F7 : 前のバッファに移動
nnoremap <F7> :bp<CR>
" F8 : 次のバッファに移動
nnoremap <F8> :bn<CR>
" F9 : gvimrcの変更を適用
nnoremap <F9> :source ~/_gvimrc<CR>
" F10 : デスクトップに保存（ファイル名入力待ち）
nnoremap <F10> :w ~/
" F11 :
" F12 :


" Insert Mode ------------------------------------------------------------------
" 基本操作
inoremap <C-a> <HOME>
inoremap <C-e> <END>
inoremap <C-d> <DEL>
inoremap <C-b> <BS>
inoremap <C-?> <BS>
inoremap <C-q> <C-^>
inoremap <C-h> <LEFT>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>

" Command Mode -----------------------------------------------------------------
" 基本操作
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>
cnoremap <C-d> <DEL>
cnoremap <C-b> <BS>
cnoremap <C-q> <C-^>
cnoremap <C-h> <LEFT>
cnoremap <C-j> <DOWN>
cnoremap <C-k> <UP>
cnoremap <C-l> <RIGHT>

" 貼り付け
cnoremap <C-p> <C-r>+
