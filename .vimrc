" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ "
"  oooooo     oooo ooooo ooo        ooooo ooooooooo.     .oooooo.   "
"   `888.     .8'  `888' `88.       .888' `888   `Y88.  d8P'  `Y8b  "
"    `888.   .8'    888   888b     d'888   888   .d88' 888          "
"     `888. .8'     888   8 Y88. .P  888   888ooo88P'  888          "
"      `888.8'      888   8  `888'   888   888`88b.    888          "
"       `888'       888   8    Y     888   888  `88b.  `88b    ooo  "
"        `8'       o888o o8o        o888o o888o  o888o  `Y8bood8P'  "
" vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv "

let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif

set nocompatible

let s:dein_base = '~/.cache/dein/'
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath+=' .. s:dein_src

call dein#begin(s:dein_base)
call dein#add(s:dein_src)
call dein#add('w0ng/vim-hybrid')
call dein#add('itchyny/lightline.vim')
call dein#add('scrooloose/syntastic')
call dein#add('h1mesuke/vim-alignta')
call dein#add('slim-template/vim-slim')
call dein#add('fatih/vim-go')
call dein#add('majutsushi/tagbar')
call dein#add('sakuraiyuta/commentout.vim')
call dein#add('hashivim/vim-hashicorp-tools')
call dein#add('leafgarland/typescript-vim')
call dein#add('google/vim-jsonnet')
call dein#add('fgsch/vim-varnish')
call dein#add('hashivim/vim-terraform')
call dein#end()

filetype indent plugin on

if has('syntax')
  syntax on
endif

if dein#check_install()
 call dein#install()
endif

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,latin1,default
set backspace=indent,eol,start

" sudo apt-get install ncurses-term
" find /usr/share/terminfo -name '*256*'
" vim ~/.bashrc
" export TERM="gnome-256color"

" colorscheme elflord
" colorscheme koehler
" colorscheme desert

let g:hybrid_custom_term_colors = 1
set background=dark
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

noremap <silent><Leader>t :TagbarToggle<CR>

au FileType go nmap <leader>r <Plug>(go-run)

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'javascript', 'scss', 'slim', 'go', 'cpp', 'tf'], 'passive_filetypes': [] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_slim_checkers = ['slim_lint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_checkers = ['cpplint']

au BufNewFile,BufRead *.json.jbuilder set ft=ruby
au BufNewFile,BufRead *.pkr.hcl set ft=terraform
au BufWrite *.pkr.hcl,*.tf,*.tfvars :TerraformFmt
