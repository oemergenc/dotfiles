syntax enable
colorscheme monokai
set number                " show line numbers
set cursorline            " highlight current line
set showcmd               " show command in bottom bar
set wildmenu              " visual autocomplete for command menu
set showmatch             " highlight matching [{()}]
set incsearch             " search as characters are entered
set hlsearch              " highlight matches
set clipboard=unnamedplus " Copy default to system clipboard
set smartindent           " 
set tabstop=4             " An indentation every four columns
set expandtab             " Tabs are spaces, not tabs
set shiftwidth=4          " Use indents of 4 spaces
set encoding=utf-8
set noshowmode            " Do not show native vim mode line at the bottom

" Custom Bindings for move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" make vim recognize alt key
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
     let c = nr2char(1+char2nr(c))
endw
set timeout ttimeoutlen=50

" plugins
" auto install vim-plug manager
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dir
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $HOME/.vimrc
endif

" install plugins
call plug#begin('~/.vim/plugged')
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
call plug#end()

" easy motion config
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
