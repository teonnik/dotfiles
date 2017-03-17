set nocompatible              			" be iMproved, required(Vundle)
filetype off                  			" required(Vundle)

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	
	Plugin 'VundleVim/Vundle.vim'			"plugin manager

	Plugin 'altercation/vim-colors-solarized' 	"gvim configuration
	
	Plugin 'Raimondi/delimitMate' 			"closing brackets
	
    Plugin 'kien/ctrlp.vim'         "fuzzy search

    Plugin 'bling/vim-airline'      "status line

    Plugin 'Valloric/YouCompleteMe' "autocompletion

    Plugin 'tpope/vim-fugitive'    "git plugin

call vundle#end()            
filetype plugin indent on			"file type detection (Vundle required)   

set backupdir=~/.vim/tmp,.      
set directory=~/.vim/tmp,.
set exrc
set secure
set colorcolumn=80		"shows the 80th column

"UI Config
set number 			    " shows line numbers
set nowrap              "lines are not wrapped
set showcmd             " show command in bottom bar
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " matching bracket highlighting

"Search
set hlsearch			"highlights search items

set backspace=indent,eol,start 
set title

" Navigation {{{
" Start and end of line
nnoremap H ^
nnoremap L $
" }}}

" Manipulate windows {{{
nnoremap <A-Left> <C-w>h
nnoremap <A-Down> <C-w>j
nnoremap <A-Up> <C-w>k
nnoremap <A-Right> <C-w>l

inoremap <A-Left> <C-o><C-w>h
inoremap <A-Down> <C-o><C-w>j
inoremap <A-Up> <C-o><C-w>k
inoremap <A-Right> <C-o><C-w>l
" }}}

" Do not create backup files
set nobackup
set nowritebackup
set noswapfile

:let mapleader = ","

" Fast saving and closing
nnoremap <leader><leader> :w<cr>
nnoremap <leader>q :q!<cr>
nnoremap <leader>w :wq<cr>

" Opening splits
nnoremap <leader>v <C-w><C-v><C-w>l
nnoremap <leader>s <C-w>s

" Tab navigation like Firefox.
nnoremap <silent> <C-S-tab> :tabprevious<CR>
nnoremap <silent> <C-tab>   :tabnext<CR>
nnoremap <silent> <C-t>     :tabnew<CR>
inoremap <silent> <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <silent> <C-tab>   <Esc>:tabnext<CR>i
inoremap <silent> <C-t>     <Esc>:tabnew<CR>

"Tabs
set tabstop=4			"tab width is equal to 4 spaces
set shiftwidth=4		"inserts 4 spaces on identation
set expandtab			"expands tabs into spaces

"Indentation
set autoindent          "simple indentation(does not interfere)
set cindent             "smart indentation
set smartindent         " -=-
set laststatus=2        "displays status line always

"Errors
autocmd GUIEnter * set vb t_vb= " for your GUI
autocmd VimEnter * set vb t_vb=

"Colors
set t_Co=256            "256 colors for termninal vim
syntax enable           " enable syntax processing

"Session revovery options
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

"Plugin Ycm
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py' "sets YCM conf file
let g:ycm_confirm_extra_conf = 0        "Prevents config file an issue with YCM
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>

"Cursor movement
set whichwrap+=<,>,h,l,[,]
