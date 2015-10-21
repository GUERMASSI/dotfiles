"===============================================================================
" Unix specific configuration
"===============================================================================

" Set path.
let $PATH = expand('~/bin').':/usr/local/bin/:'.$PATH

if has('gui_running')
  finish
endif

"===============================================================================
" Command line interface configuration
"===============================================================================

" Enable 256 color terminal.
set t_Co=256

if &term =~# 'xterm'
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin('0i')
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin('')
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>

    " Optimize vertical split.
    " Note: Newest terminal is needed.
    " let &t_ti .= "\e[?6;69h"
    " let &t_te .= "\e7\e[?6;69l\e8"
    " let &t_CV = "\e[%i%p1%d;%p2%ds"
    " let &t_CS = "y"
endif

if has('gui')
    " Use CSApprox.vim
    NeoBundleSource csapprox

    " Load theme
    NeoBundleSource flashy-vim

    " Convert colorscheme in Konsole.
    let g:CSApprox_konsole = 1
    let g:CSApprox_attr_map = {
        \ 'bold' : 'bold',
        \ 'italic' : 'italic',
        \ 'sp' : ''
        \ }
    if !exists('g:colors_name')
        execute 'colorscheme' globpath(&runtimepath,
            \ 'colors/flashy_vim.vim') != '' ? 'flashy_vim' : 'desert'
    endif
else
    " Use guicolorscheme.vim
    NeoBundleSource vim-guicolorscheme

    " Load theme
    NeoBundleSource flashy-vim

    GuiColorScheme flashy_vim

    " Disable error messages.
    let g:CSApprox_verbose_level = 0
endif

" Using the mouse on a terminal.
if has('mouse') && !has('nvim')
    set mouse=a
    if has('mouse_sgr') || v:version > 703 ||
            \ v:version == 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif

    " Paste.
    nnoremap <RightMouse> "+p
    xnoremap <RightMouse> "+p
    inoremap <RightMouse> <C-r><C-o>+
    cnoremap <RightMouse> <C-r>+
endif
