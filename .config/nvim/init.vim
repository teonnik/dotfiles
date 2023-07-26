set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vim/vimrc

lua << EOF

-- [[ Configure Completion ]]
--
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#no-snippet-plugin
-- :help nvim-cmp
--
-- Set up nvim-cmp.
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require'cmp'
cmp.setup({
  completion = {
    autocomplete = false
  },
  snippet = {
    -- REQUIRED - a snippet engine must be specified as some LSPs use snippets by default
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- super-tab
    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  }),
})


-- [[ Configure LSPs ]]
--
-- require'lspconfig'.clangd.setup{}
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_lsp_attach = function(client, bufnr)
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
-- default configuration : https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clangd.lua
nvim_lsp['clangd'].setup {
  on_attach = custom_lsp_attach,
  cmd = {
        "clangd",
        "--compile-commands-dir=/home/teonnik/code/drivesim-ov",
        "--log=verbose",
        --"--background-index=0",
        "--background-index",
        -- "-j=1",
        -- "--clang-tidy=0",
  },
  flags = {
    debounce_text_changes = 150,
  },
  filetypes = { "c", "cpp", "cu", "cuda" },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- https://github.com/python-lsp/python-lsp-server/issues/120
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
nvim_lsp['pylsp'].setup {
  on_attach = custom_lsp_attach,
  settings = {
    pylsp = {
      plugins = {
        jedi = {
          environment = '/home/teonnik/code/drivesim-ov/_build/linux-x86_64/release/python.sh'
        }
      }
    }
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}

-- nvim_lsp['texlab'].setup {
--   on_attach = custom_lsp_attach
-- }

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
--
-- Taken from : https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'cpp', 'cuda', 'vim', 'lua', 'python', 'help' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  }
}



-- [[ Configure Debugger ]]
--
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
--local dap = require('dap')
--dap.adapters.cpp = {
--  name = 'lldb'
--  type = 'executable',
--  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
--}
--
---- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#pick-a-process
--dap.configurations.cpp = {
--    {
--      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
--      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--      name = "Attach to process",
--      type = 'cpp',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
--      request = 'attach',
--      pid = require('dap.utils').pick_process,
--      args = {},
--    },
--}

EOF
