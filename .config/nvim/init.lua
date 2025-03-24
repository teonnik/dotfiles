-------- PLUGIN MANAGER

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out =
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-------- LEADER

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-------- OPTIONS

vim.opt.backup = false -- don't create a backup file
vim.opt.breakindent = true -- indent wrapped lines
vim.opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- only set clipboard if not in ssh, to make sure the OSC 52 (Neovim >= 0.10.0)
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- completion menu
vim.opt.conceallevel = 2 -- hide * markup for bold and italic, but not markers with substitutions
vim.opt.cursorline = true -- highlight the text line of the cursor
vim.opt.expandtab = true -- turn a tab into spaces
vim.opt.foldcolumn = '0' -- don't use a fold column
vim.opt.foldlevel = 99 -- higher number keeps all folds open
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.hidden = true -- hide buffers even with unsaved changes
vim.opt.history = 500 -- set number of lines to remember
vim.opt.hlsearch = true -- highlight search results
vim.opt.ignorecase = true -- ignore case when searching in general
vim.opt.incsearch = true -- search as characters are entered
vim.opt.lazyredraw = true -- don't redraw while executing macros (for performance)
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a' -- enable mouse mode
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true
vim.opt.scrolloff = 10 -- " set 10 lines to the cursor when moving vertically
vim.opt.shiftwidth = 4 -- " spaces for autoindents
vim.opt.showmatch = true -- " show matching brackets
vim.opt.signcolumn = 'yes' -- keep signcolumn on by default
vim.opt.smartcase = true -- be case sensitive when typing uppercase
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false -- don't create swap files
vim.opt.tabstop = 4 -- " make tabs 4 spaces
vim.opt.termguicolors = true
vim.opt.textwidth = 80 -- set max inserted text width
vim.opt.undofile = true -- save undo history
vim.opt.virtualedit = 'block' -- improve the Viusaul Block mode (C-v)
vim.opt.whichwrap:append('<,>,h,l') -- wrap left and right when at the end
vim.opt.wildignorecase = true -- " ignore case in wildmenu
vim.opt.winminwidth = 5 -- minimum window width
vim.opt.wrap = false -- don't wrap lines by default

-------- KEYMAPS

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights' })
vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = 'Left window' })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = 'Right window' })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { desc = 'Down window' })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { desc = 'Up window' })
vim.keymap.set('t', '<C-n>', '<C-\\><C-n>', { desc = 'Terminal normal mode' })
vim.keymap.set(
  'n',
  '<leader>c',
  ':cclose<cr> :lclose<cr> :pclose<cr>',
  { desc = 'Close current buffer' }
)
vim.keymap.set('n', '<leader>e', ':e<space>', { desc = 'Open a file' })
vim.keymap.set('n', '<leader>pp', '<cmd>TNNCopyPath %<cr>', { desc = 'Copy relative file path' })
vim.keymap.set('n', '<leader>pf', '<cmd>TNNCopyPath %:p<cr>', { desc = 'Copy full file path' })
vim.keymap.set('n', '<leader>pn', '<cmd>TNNCopyPath %:t<cr>', { desc = 'Copy filename' })
vim.keymap.set('n', '<leader>w', ':w!<CR>', { desc = 'Save quickly' })

------- PLUGINS

require('lazy').setup({
  'nvim-tree/nvim-web-devicons', -- icons for `fzf-lua`, `oil` and `lualine`
  'nvim-lualine/lualine.nvim', -- statusline
  { -- colorscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
      })

      -- Apply the colorscheme
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  { -- fuzzy finder
    'ibhagwan/fzf-lua',
    keys = {
      { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'FZF: live grep' },
      { '<leader>.', '<cmd>FzfLua grep_cword<cr>', desc = 'FZF: grep current word' },
      { '<leader>f', '<cmd>FzfLua files<cr>', desc = 'FZF: find files' },
      { '<leader>b', '<cmd>FzfLua buffers<cr>', desc = 'FZF: list buffers' },
      { '<leader>k', '<cmd>FzfLua keymaps<cr>', desc = 'FZF: list keymaps' },
      { '<leader>sc', '<cmd>FzfLua command_history<cr>', desc = 'FZF: command history' },
      { '<leader>sr', '<cmd>FzfLua registers<cr>', desc = 'FZF: list registers' },
      { '<leader>ya', '<cmd>FzfLua lsp_code_actions<cr>', desc = 'FZF-LSP: code actions' },
      { '<leader>yl', '<cmd>FzfLua lsp_references<cr>', desc = 'FZF-LSP: references' },
      { '<leader>yg', '<cmd>FzfLua lsp_definitions<cr>', desc = 'FZF-LSP: definitions' },
      { '<leader>ye', '<cmd>FzfLua lsp_document_diagnostics<cr>', desc = 'FZF-LSP: diagnostics' },
      { '<leader>ys', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'FZF-LSP: document symbols' },
    },
    config = function()
      require('fzf-lua').register_ui_select()
    end,
  },
  { -- file explorer
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['y'] = { 'actions.copy_to_system_clipboard', mode = 'n' },
      },
    },
    keys = {
      { '<leader>o', '<cmd>Oil<cr>', desc = 'Open file explorer' },
    },
    lazy = false, -- recommended to avoid issues
  },
  { -- terminal utils
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true,
    keys = {
      -- Example: `2<C-t>`opens terminal 2
      { '<C-t>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', 'Toggle terminal' },
    },
  },
  { -- (Auto)-Completion
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim', -- LSP icons
    },
    version = '*',
    lazy = false,
    opts = {
      keymap = {
        -- Discussion on different "supertab" completion defnitionios [1]
        -- [1]: https://github.com/LazyVim/LazyVim/discussions/250#discussioncomment-11882952
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        -- Use default: `C-y` to accept and `C-e` to exit menu
      },
      completion = {
        list = { selection = { preselect = false } },
        ghost_text = { enabled = true }, -- useful for previewing snippets
      },
      fuzzy = { implementation = 'rust' },
      signature = { enabled = true },
      cmdline = { enabled = false }, -- disable for now as the completion ranking is very weird...
    },
  },
  { -- syntax and navigation
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      ensure_installed = {
        'bash',
        'diff',
        'markdown',
        'markdown_inline',
        'cpp',
        'cuda',
        'vim',
        'lua',
        'python',
        'usd',
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  { -- language servers
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      local nvim_lsp = require('lspconfig')

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- LSP servers
      nvim_lsp['clangd'].setup({
        capabilities = capabilities,
        cmd = {
          'clangd',
          --"--compile-commands-dir=/home/teonnik/code/drivesim-ov",
          '--log=verbose',
          --"--background-index=0",
          '--background-index',
          -- "-j=1",
          -- "--clang-tidy=0",
          '--offset-encoding=utf-16', -- https://www.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/
        },
        flags = {
          debounce_text_changes = 150,
        },
        filetypes = { 'c', 'cpp', 'cu', 'cuda' },
      })
      nvim_lsp['pylsp'].setup({
        -- Invalid offset issue FIXED in neovim 0.11: https://github.com/rust-lang/rust-analyzer/issues/17289
        capabilities = capabilities,
      })
      nvim_lsp['rust_analyzer'].setup({
        capabilities = capabilities,
      })
      nvim_lsp['bashls'].setup({
        capabilities = capabilities,
      })
      nvim_lsp['lua_ls'].setup({
        capabilities = capabilities,
      })
    end,
  },
  { -- debugging
    'mfussenegger/nvim-dap',
    dependencies = {
      { -- inline debugging info
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
    },
    config = function()
      local dap = require('dap')
      -- Completion in REPL seems to not be supported currently : https://github.com/rcarriga/cmp-dap
      -- `lldb-vscode` is going to be renamed to `lldb-dap` https://discourse.llvm.org/t/rfc-rename-lldb-vscode-to-lldb-dap/74075/7
      dap.adapters.cpp = {
        name = 'lldb',
        type = 'executable',
        -- command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
        command = '/usr/bin/lldb-dap',
      }
      -- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#pick-a-process
      dap.configurations.cpp = {
        {
          -- If you get an "Operation not permitted" error using this, try disabling YAMA:
          --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
          name = 'Attach to process',
          type = 'cpp', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
          request = 'attach',
          pid = require('dap.utils').pick_process,
          args = {},
          -- runInTerminal=true
        },
      }

      -- stylua: ignore start
      vim.keymap.set('n', '<M-c>', function() require('dap').continue() end)
      vim.keymap.set('n', '<M-t>', function() require('dap').terminate() end)
      vim.keymap.set('n', '<M-right>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<M-down>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<M-up>', function() require('dap').step_out() end)
      vim.keymap.set('n', '<M-f>', function() require('dap').focus_frame() end)
      vim.keymap.set('n', '<M-k>', function() require('dap').up() end)
      vim.keymap.set('n', '<M-j>', function() require('dap').down() end)
      vim.keymap.set('n', '<M-u>', function() require('dap').run_to_cursor() end)
      vim.keymap.set('n', '<M-b>', function() require('dap').toggle_breakpoint() end)
      vim.keymap.set('n', '<M-del>', function() require('dap').clear_breakpoints() end)
      vim.keymap.set('n', '<M-l>', function() require('dap').list_breakpoints() end)
      -- In REPL mode LLDB commands can be run by prefixing with ` : e.g. `bt
      --
      -- https://github.com/mfussenegger/nvim-dap/discussions/381#discussioncomment-2360181
      vim.keymap.set('n', '<M-r>', function() require('dap').repl.toggle() end)
      -- stylua: ignore end
    end,
  },
  {
    'famiu/bufdelete.nvim', -- (archived) preserves window layout when deleting buffers
    keys = {
      { '<leader>d', ':Bdelete<cr>', desc = 'Close current buffer' },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim', -- indent guides
    main = 'ibl',
    opts = {
      scope = {
        enabled = false, -- don't underline outer scope
      },
    },
  },
  {
    'windwp/nvim-autopairs', -- autopairs
    event = 'InsertEnter',
    config = true,
  },

  'tpope/vim-surround', -- surround words easily
  'tpope/vim-repeat', -- repeating with `.` for many plugins
  'tpope/vim-eunuch', -- unix shell wrappers for vim
  'tpope/vim-obsession', -- record vim sessions
  'tpope/vim-fugitive', -- git integration
  'junegunn/vim-easy-align', -- align text on delimiters
  { -- navigation
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  { -- AI
    'olimorris/codecompanion.nvim',
    config = function()
      require('codecompanion').setup({
        strategies = {
          chat = { adapter = 'copilot' },
          inline = { adapter = 'copilot' },
          agent = { adapter = 'copilot' },
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
})

-------- AUTOCOMMANDS

-- wrap and check for spell in text filetypes (from Lazy)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- resize splits if window got resized (from Lazy)
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- define keymaps when lsp is attached
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    -- stylua: ignore start
    vim.keymap.set( 'n', '<leader>yg', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'LSP: Go to definition', buffer = bufnr })
    vim.keymap.set( 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'LSP: Hover docs', buffer = bufnr })
    vim.keymap.set( 'n', '<leader>yt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'LSP: Go to type definition', buffer = bufnr })
    vim.keymap.set( 'n', '<leader>yr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'LSP: Rename', buffer = bufnr })
    vim.keymap.set( 'n', '<leader>yd', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'LSP: Open diagnostic', buffer = bufnr })
    vim.keymap.set( 'n', '<leader>yf', '<cmd>lua vim.lsp.buf.format()<CR>', { desc = 'LSP: format', buffer = bufnr })
    -- stylua: ignore end
  end,
})

------- COMMANDS

vim.api.nvim_create_user_command('TNNCopyPath', function(opts)
  local expr = opts.args
  local path = vim.fn.expand(expr)
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, {
  nargs = 1, -- require one argument
  desc = 'Copy a file path based on expand() expression',
})
