execute 'source' fnamemodify(expand('<sfile>'), ':h').'/.vimrc'

tnoremap <A-a> <C-\><C-n>

" New terminal in split
nnoremap <silent> [Window]t :<C-u>vsplit \| terminal<CR>
