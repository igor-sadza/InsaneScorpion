execute pathogen#infect()
syntax on
filetype plugin indent on

com!  -nargs=* -bar -bang -complete=dir  Lexplore  call netrw#Lexplore(<q-args>, <bang>0)

fun! Lexplore(dir, right)
  if exists("t:netrw_lexbufnr")
  " close down netrw explorer window
  let lexwinnr = bufwinnr(t:netrw_lexbufnr)
  if lexwinnr != -1
    let curwin = winnr()
    exe lexwinnr."wincmd w"
    close
    exe curwin."wincmd w"
  endif
  unlet t:netrw_lexbufnr

  else
    " open netrw explorer window in the dir of current file
    " (even on remote files)
    let path = substitute(exists("b:netrw_curdir")? b:netrw_curdir : expand("%:p"), '^\(.*[/\\]\)[^/\\]*$','\1','e')
    exe (a:right? "botright" : "topleft")." vertical ".((g:netrw_winsize > 0)? (g:netrw_winsize*winwidth(0))/100 : -g:netrw_winsize) . " new"
    if a:dir != ""
      exe "Explore ".a:dir
    else
      exe "Explore ".path
    endif
    setlocal winfixwidth
    let t:netrw_lexbufnr = bufnr("%")
  endif
endfun

" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
let g:netrw_browse_split = 4

" when using v key, put new files to right 
let g:netrw_altv=1

" set term size to 10
" set termwinsize=10x0

" show line numbers
set number

" set tab to 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" put swap files to ~/.vim folder
set directory=$HOME/.vim/vim_swap/

autocmd WinEnter * setlocal cursorline
autocmd WinEnter * setlocal signcolumn=auto

autocmd WinLeave * setlocal nocursorline
autocmd WinLeave * setlocal signcolumn=no

"If you want to always change pwd while browsing around with netrw you could use:
"let g:netrw_keepdir = 0
let g:netrw_keepdir= 1
