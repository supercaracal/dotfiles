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

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

NeoBundle 'gmarik/vundle'
NeoBundle 'taglist.vim'
NeoBundle 'sakuraiyuta/commentout.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'w0ng/vim-hybrid'

filetype plugin indent on

NeoBundleCheck
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,latin1,default
set backspace=indent,eol,start

" sudo apt-get install ncurses-term
" find /usr/share/terminfo -name '*256*'
" vim ~/.bashrc
" export TERM="gnome-256color"

if has("syntax")
  syntax on
endif

" colorscheme elflord
" colorscheme koehler
" colorscheme desert

let g:hybrid_use_Xresources = 1
colorscheme hybrid

set cmdheight=2
set laststatus=2
set showcmd

set nowrap
set nobackup
set noswapfile

set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set number
set list
set lcs=tab:^^,eol:~

set hlsearch
set incsearch
set ignorecase
set wildignorecase

set tags=~/.tags

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

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'javascript'], 'passive_filetypes': [] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
