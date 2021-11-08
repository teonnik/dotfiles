set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc


" TODO: incorporate these plugins for neovim
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter'

" ----------------------------
" Plugins
" ----------------------------

" lua << EOF
" -- require'lspconfig'.clangd.setup{}
" local nvim_lsp = require('lspconfig')
" 
" -- Use an on_attach function to only map the following keys
" -- after the language server attaches to the current buffer
" local on_attach = function(client, bufnr)
"   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
"   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
" 
"   -- Enable completion triggered by <c-x><c-o>
"   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
" 
"   -- Mappings.
"   local opts = { noremap=true, silent=true }
" 
"   -- See `:help vim.lsp.*` for documentation on any of the below functions
"   buf_set_keymap('n', '<leader>lg', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
"   buf_set_keymap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
"   buf_set_keymap('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"   buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"   buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"   buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
"   buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
" 
" end
" 
" -- Use a loop to conveniently call 'setup' on multiple servers and
" -- map buffer local keybindings when the language server attaches
" local servers = { 'clangd' }
" for _, lsp in ipairs(servers) do
"   nvim_lsp[lsp].setup {
"     on_attach = on_attach,
"     flags = {
"       debounce_text_changes = 150,
"     }
"   }
" end
" EOF