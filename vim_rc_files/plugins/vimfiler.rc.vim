"---------------------------------------------------------------------------
" vimfiler.vim
"

let g:vimfiler_enable_clipboard = 0
let g:vimfiler_safe_mode_by_default = 0

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_detect_drives = split(glob('/mnt/*'), '\n') +
      \ split(glob('/media/*'), '\n') +
      \ split(glob('/Users/*'), '\n')

" %p : full path
" %d : current directory
" %f : filename
" %F : filename removed extensions
" %* : filenames
" %# : filenames fullpath
let g:vimfiler_sendto = {
      \ 'unzip' : 'unzip %f',
      \ 'zip' : 'zip -r %F.zip %*',
      \ 'Inkscape' : 'inkspace',
      \ 'GIMP' : 'gimp %*',
      \ 'gedit' : 'gedit',
      \ }

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

let g:vimfiler_quick_look_command = 'gloobus-preview'

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() "{{{
  call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
  call vimfiler#set_execute_file('txt', 'vim')

  " Overwrite settings.
  nnoremap <silent><buffer> J
        \ <C-u>:Unite -buffer-name=files -default-action=lcd directory_mru<CR>
  " Call sendto.
  " nnoremap <buffer> - <C-u>:Unite sendto<CR>
  " setlocal cursorline

  nmap <buffer> O <Plug>(vimfiler_sync_with_another_vimfiler)
  nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
  nmap <buffer> p <Plug>(vimfiler_quick_look)
  nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)
  nmap <buffer> n <Plug>(vimfiler_new_file)

  " Migemo search.
  if !empty(unite#get_filters('matcher_migemo'))
    nnoremap <silent><buffer><expr> /  line('$') > 10000 ?  'g/' :
          \ ":\<C-u>Unite -buffer-name=search -start-insert line_migemo\<CR>"
  endif

  " One key file operation.
  " nmap <buffer> c <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)
  " nmap <buffer> m <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_move_file)
  " nmap <buffer> d <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_delete_file)
endfunction"}}}
