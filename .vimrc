" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ "
"  oooooo     oooo ooooo ooo        ooooo ooooooooo.     .oooooo.   "
"   `888.     .8'  `888' `88.       .888' `888   `Y88.  d8P'  `Y8b  "
"    `888.   .8'    888   888b     d'888   888   .d88' 888          "
"     `888. .8'     888   8 Y88. .P  888   888ooo88P'  888          "
"      `888.8'      888   8  `888'   888   888`88b.    888          "
"       `888'       888   8    Y     888   888  `88b.  `88b    ooo  "
"        `8'       o888o o8o        o888o o888o  o888o  `Y8bood8P'  "
" vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv "

" bundle plugin ~~~~~~~~~~~~~~~~~~~~~~~~~
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'gmarik/vundle'
NeoBundle 'taglist.vim'
NeoBundle 'sakuraiyuta/commentout.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'h1mesuke/vim-alignta'

filetype plugin indent on

NeoBundleCheck
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

augroup myvimrc
  autocmd!
augroup END

set fileencodings=ucs-bom,utf-8,cp932,euc-jp,latin1,default
set backspace=indent,eol,start

" sudo apt-get install ncurses-term
" find /usr/share/terminfo -name '*256*'
" vim ~/.bashrc
" export TERM="gnome-256color"

if has("syntax")
  syntax on
endif

colorscheme koehler

set cmdheight=2
set laststatus=2
set showcmd

if (1)
  let g:Powerline_symbols='fancy'
else
  let g:Powerline_loaded=0
  set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
endif

set nowrap
set nobackup
set noswapfile

set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd myvimrc FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd myvimrc FileType eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

set number
set list
set lcs=tab:^^,eol:~

set hlsearch
set incsearch
set ignorecase
set wildignorecase

function! ShowJpSpace()
  syntax match JpSpace "　" display containedin=ALL
  highlight JpSpace term=underline ctermbg=Blue guibg=darkgray gui=underline
endf
au BufRead,BufNew * call ShowJpSpace()

set tags=~/tags

let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_underbar_completion=1

let Tlist_WinWidth=40
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>

vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap <silent><Leader>al :Align @1 =><CR>
vnoremap y "+y
vnoremap x "+x

noremap p "+p
noremap dd "+dd
noremap <silent><Leader>tl :TlistToggle<CR>
