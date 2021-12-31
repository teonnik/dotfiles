" ----------------------------
" Plugins
" ----------------------------

call plug#begin(stdpath('data') . '/plugged')
  Plug 'junegunn/fzf.vim'               " fuzzy search
  Plug 'junegunn/vim-easy-align'        " align text on delimiters
  Plug 'tpope/vim-surround'             " surround words easily
  Plug 'tpope/vim-eunuch'               " unix shell wrappers for vim
  Plug 'bling/vim-airline'              " status line
  Plug 'morhetz/gruvbox'                " color scheme
  Plug 'justinmk/vim-sneak'             " jump to locations quickly
  Plug 'ackyshake/VimCompletesMe'       " use <Tab> for vim's `ins-completion`
  Plug 'neovim/nvim-lspconfig'          " neovim's built-in LSP
  "Plug 'hrsh7th/nvim-cmp'                " autocompletion for nvim-lspconfig
  "Plug 'nvim-treesitter/nvim-treesitter' " syntax highlighting
call plug#end()


" ----------------------------
" General
" ----------------------------

set history=500  " set number of lines to remember
set autoread     " auto read when a file is changed from the outside
set hidden       " allow to hide buffers even with unsaved changes
set lazyredraw   " don't redraw while executing macros (for performance)

" copy to system clipboard
set clipboard=unnamedplus,unnamed

" ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set ignorecase   " ignore case when searching in general
set smartcase    " be case sensitive when typing uppercase
set hlsearch     " highlight search results
set incsearch    " search as characters are entered

" No annoying sounds on errors
set noerrorbells
set novisualbell
set t_vb=


" Syntax highlighting
syntax enable
set background=dark

set encoding=utf8    " set utf8 as standard encoding
set ffs=unix,dos,mac " use Unix as the standard file type

" turn backup off, since most stuff is in git anyway
set nobackup
set noswapfile

set expandtab       " turn a tab into spaces
set smarttab        " be smart when using tabs
set tabstop=2       " make tabs 2 spaces
set shiftwidth=2    " spaces for autoindents
set autoindent      " on new lines, match indent of previous line

" mark tabs and trailing spaces
set list
set listchars=tab:-.,trail:.

set wrap                         " wrap lines
set whichwrap+=<,>,h,l           " wrap left and right when at the end
set ruler                        " always show current position
set number                       " show line numbers
set showcmd                      " show command in bottom bar
"set textwidth=80                 " set max inserted text width
set colorcolumn=+1               " highlight the textwidth column
set cursorline                   " highlight the current line
set showmatch                    " show matching brackets
set scrolloff=5                  " set 5 lines to the cursor when moving vertically
set backspace=indent,eol,start   " make backspace work as expected

set wildmenu       " visual autocomplete for command menu
set wildignorecase " ignore case in wildmenu

set completeopt=menu,menuone,noselect " completion menu

filetype indent on  " load filetype-specific indent files
filetype plugin on  " enable filetype plugins

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" treat .tpp files as C++ files
au BufEnter *.tpp :setlocal filetype=cpp

" ----------------------------
" Bindings
" ----------------------------

" set `space` as <leader>
let mapleader=" "

" paste multiple times by default
xnoremap p pgvy

" list buffers and wait for selection to open
nnoremap <leader>b :ls<cr>:b<space>

" close the quickfix, location and preview windows
nnoremap <leader>c :cclose<cr> :lclose<cr> :pclose<cr>

" list buffers and wait for selection to close
nnoremap <leader>d :bd<cr>

" open a file
nnoremap <leader>e :e<space>

" Search for files with fzf and ag
nnoremap <leader>f :Files<cr>

" set language
nnoremap <leader>lbg :set keymap=bulgarian-phonetic<cr>
nnoremap <leader>len :set keymap=<cr>

" toggle line (n)umbers
nnoremap <leader>n :set nu!<cr>

" open netrw in the current buffer
nnoremap <leader>o :Explore<cr>

" quit vim
nnoremap <leader>q :q!<cr>

" source local .lvimrc
nnoremap <leader>s :so .lvimrc<cr>

" execute current file
nnoremap <leader>ue :!%:p<cr>

" switch to the directory of the (o)pen buffer
map      <leader>uo :cd %:p:h<cr>:pwd<cr>

" toggle paste mode
map      <leader>up :setlocal paste!<cr>

" reload files that have changed outside the editor
nnoremap <leader>ur :edit<cr>

" trim whitespace
nnoremap <leader>ut :call TrimWhitespace()<cr>

" toggle spell checking
noremap  <leader>us :setlocal spell! spelllang=en_us<cr>

" save quickly
nmap     <leader>w :w!<cr>

" grep the code base using the silver searcher
nnoremap <leader>/ :Ag<space>

" remove highlighting
map      <silent> <leader><cr> :noh<cr>

" Disable Ex mode
nnoremap Q <Nop>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" ----------------------------
" Functions
" ----------------------------

" Use with :call TrimWhitespace()
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

" ----------------------------
" Commands
" ----------------------------

" capture output in a scratch buffer :R
:command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide | r !<args>


" ----------------------------
" Plugins
" ----------------------------

" --- gruvbox ---
"
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'soft'

" --- sneak ---
"
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1


lua << EOF
-- require'lspconfig'.clangd.setup{}
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>yg', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>yh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>yt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>yr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>yl', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>yd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>yf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
