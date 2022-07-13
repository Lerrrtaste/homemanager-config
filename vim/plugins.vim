" whichkey
let g:which_key_map = {}
" autocmd! User vim-which-key call which_key#register('<Space>','g:which_key_map')
call which_key#register('<Space>', 'g:which_key_map')


nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>

set timeoutlen=500
set signcolumn=yes

