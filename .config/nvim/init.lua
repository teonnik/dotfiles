-------- PLUGIN MANAGER

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-------- LEADER

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------- OPTIONS

vim.opt.backup = false -- don't create a backup file
vim.opt.breakindent = true -- indent wrapped lines
-- vim.opt.clipboard = 'unnamedplus' -- copy from/into the system clipboard (i.e. register "+)
-- vim.g.clipboard = 'osc52' -- set in `ssh` sessions to enable copying - `:checkhealth`
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- completion menu
vim.opt.conceallevel = 2 -- hide * markup for bold and italic, but not markers with substitutions
vim.opt.cursorline = true -- highlight the text line of the cursor
vim.opt.expandtab = true -- turn a tab into spaces
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
vim.opt.foldcolumn = "0" -- don't use a fold column
vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99 -- keep all folds open at the start
vim.opt.hidden = true -- hide buffers even with unsaved changes
vim.opt.history = 500 -- set number of lines to remember
vim.opt.hlsearch = true -- highlight search results
vim.opt.ignorecase = true -- ignore case when searching in general
vim.opt.incsearch = true -- search as characters are entered
vim.opt.lazyredraw = true -- don't redraw while executing macros (for performance)
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.number = true -- show line numbers
-- vim.opt.relativenumber = true
vim.opt.scrolloff = 10 -- set 10 lines to the cursor when moving vertically
vim.opt.shiftwidth = 4 -- spaces for autoindents
vim.opt.showmatch = true -- show matching brackets
vim.opt.showmode = false -- the mode is shown in the statusline already
vim.opt.signcolumn = "yes" -- keep signcolumn on by default for diagnostics, breakpoints and VCS changes
vim.opt.smartcase = true -- be case sensitive when typing uppercase
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false -- don't create swap files
vim.opt.tabstop = 4 -- " make tabs 4 spaces
vim.opt.termguicolors = true
-- vim.opt.textwidth = 80 -- set max inserted text width
vim.opt.undofile = true -- save undo history
vim.opt.virtualedit = "block" -- improve the Viusaul Block mode (C-v)
vim.opt.whichwrap:append("<,>,h,l") -- wrap left and right when at the end
vim.opt.wildignorecase = true -- " ignore case in wildmenu
vim.opt.winminwidth = 5 -- minimum window width
vim.opt.wrap = false -- don't wrap lines by default

-------- KEYMAPS

-- stylua: ignore start
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights' })
vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = 'Left window' })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = 'Right window' })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { desc = 'Down window' })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { desc = 'Up window' })
vim.keymap.set('t', '<C-n>', '<C-\\><C-n>', { desc = 'Terminal normal mode' })
vim.keymap.set('n', '<leader>c', ':cclose<cr> :lclose<cr> :pclose<cr>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>e', ':e<space>', { desc = 'Open a file' })
vim.keymap.set('n', '<leader>l', '<cmd>TNNToggleKeymap<cr>', { desc = 'Toggle the Bulgarian phonetic keymap' })
vim.keymap.set({'n', 'x'}, '<leader>p', '"0p', { desc = 'Paste the last yanked text' })
vim.keymap.set('n', '<leader>up', '<cmd>TNNCopyPath %<cr>', { desc = 'Copy relative file path' })
vim.keymap.set('n', '<leader>uf', '<cmd>TNNCopyPath %:p<cr>', { desc = 'Copy full file path' })
vim.keymap.set("n", "<leader>uw",
    function()
        vim.o.wrap = not vim.o.wrap
        print("Wrap " .. (vim.o.wrap and "enabled" or "disabled"))
    end,
    { desc = "Toggle line wrapping" }
)
vim.keymap.set('n', '<leader>un', '<cmd>TNNCopyPath %:t<cr>', { desc = 'Copy filename' })
vim.keymap.set('n', '<leader>w', ':w!<cr>', { desc = 'Save quickly' })
-- Check clipboard support and provider with `:checkhealth`
vim.keymap.set({'n', 'x'}, ',y', '"+y', { desc = 'Copy into clipboard' })
vim.keymap.set({'n', 'x'}, ',p', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set({'n', 'x'}, ',d', '"+d', { desc = 'Cut into clipboard' })
-- stylua: ignore end

------- PLUGINS

require("lazy").setup({
    "tpope/vim-eunuch", -- unix shell wrappers for vim
    "junegunn/vim-easy-align", -- align text on delimiters

    { -- icons for `fzf-lua`, `oil` and `lualine`
        "nvim-tree/nvim-web-devicons",
    },
    { -- surround selections
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    { -- session management
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
    },
    { -- statusline
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "catppuccin",
                -- globalstatus = true,
            },
            sections = {
                lualine_x = {
                    { -- keymap : https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets
                        function()
                            if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
                                return "⌨ " .. vim.b.keymap_name
                            end
                            return ""
                        end,
                    },
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        },
    },
    { -- colorscheme
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
            })

            -- Apply the colorscheme
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    { -- fuzzy finder
        "ibhagwan/fzf-lua",
        lazy = false,
        keys = {
            { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "FZF: live grep" },
            { "<leader>.", "<cmd>FzfLua grep_cword<cr>", desc = "FZF: grep current word" },
            { "<leader>f", "<cmd>FzfLua files<cr>", desc = "FZF: find files" },
            { "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "FZF: list buffers" },
            { "<leader>k", "<cmd>FzfLua keymaps<cr>", desc = "FZF: list keymaps" },
            { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "FZF: command history" },
            { "<leader>sr", "<cmd>FzfLua registers<cr>", desc = "FZF: list registers" },
            { "<leader>ya", "<cmd>FzfLua lsp_code_actions<cr>", desc = "FZF-LSP: code actions" },
            { "<leader>yl", "<cmd>FzfLua lsp_references<cr>", desc = "FZF-LSP: references" },
            { "<leader>yg", "<cmd>FzfLua lsp_definitions<cr>", desc = "FZF-LSP: definitions" },
            { "<leader>ye", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "FZF-LSP: diagnostics" },
            { "<leader>ys", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "FZF-LSP: document symbols" },
        },
        config = function()
            -- use `fzf-lua` for replace vim.ui.select
            require("fzf-lua").register_ui_select()
        end,
    },
    { -- file explorer
        "stevearc/oil.nvim",
        opts = {
            view_options = {
                show_hidden = true,
            },
            -- keymaps = {
            --   ['y'] = { 'actions.copy_to_system_clipboard', mode = 'n' },
            -- },
        },
        keys = {
            { "<leader>o", "<cmd>Oil<cr>", desc = "Open file explorer" },
        },
        lazy = false, -- recommended to avoid issues
    },
    { -- terminal utils
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true,
        keys = {
            -- Example: `2<C-t>`opens terminal 2
            { "<C-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', "Toggle terminal" },
        },
    },
    { -- (Auto)-Completion
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim", -- LSP icons
        },
        version = "*",
        lazy = false,
        opts = {
            keymap = {
                -- Discussion on different "supertab" completion defnitionios [1]
                -- [1]: https://github.com/LazyVim/LazyVim/discussions/250#discussioncomment-11882952
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                -- Use default: `C-y` to accept and `C-e` to exit menu
            },
            completion = {
                list = { selection = { preselect = false } },
                ghost_text = { enabled = true }, -- useful for previewing snippets
            },
            fuzzy = { implementation = "rust" },
            signature = { enabled = true },
            cmdline = { enabled = false }, -- disable for now as the completion ranking is very weird...
        },
    },
    { -- syntax and navigation

        -- * Requires `tree-sitter-cli`
        -- * Check status with `:checkhealth nvim-treesitter`
        --
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        lazy = false,
        config = function()
            local ts = require("nvim-treesitter")
            ts.install({
                "bash",
                "diff",
                "markdown",
                "markdown_inline",
                "cpp",
                "cuda",
                "cmake",
                "vim",
                "lua",
                "python",
                "usd",
            })

            -- enable highlighting (Neovim-side)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    -- This is a no-op if there is no parser for the buffer,
                    -- vim's default regex-based syntax highlighting is active
                    pcall(vim.treesitter.start)
                end,
            })

            -- enable indentation (plugin-side)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    { -- language servers
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- LSP servers
            vim.lsp.config("clangd", {
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    --"--compile-commands-dir=/home/teonnik/code/drivesim-ov",
                    "--log=verbose",
                    --"--background-index=0",
                    "--background-index",
                    -- "-j=1",
                    -- "--clang-tidy=0",
                    "--offset-encoding=utf-16", -- https://www.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/
                },
                flags = {
                    debounce_text_changes = 150,
                },
                filetypes = { "c", "cpp", "cu", "cuda" },
            })
            vim.lsp.enable("clangd")

            for _, server in ipairs({
                "pylsp",
                "ruff",
                "rust_analyzer",
                "bashls",
                "lua_ls",
            }) do
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
                vim.lsp.enable(server)
            end
        end,
    },
    { -- debugging
        "mfussenegger/nvim-dap",
        dependencies = {
            { -- inline debugging info
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
        },
        config = function()
            local dap = require("dap")
            -- Completion in REPL seems to not be supported currently : https://github.com/rcarriga/cmp-dap
            -- `lldb-vscode` is going to be renamed to `lldb-dap` https://discourse.llvm.org/t/rfc-rename-lldb-vscode-to-lldb-dap/74075/7
            dap.adapters.cpp = {
                name = "lldb",
                type = "executable",
                -- command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
                command = "/usr/bin/lldb-dap",
            }
            -- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#pick-a-process
            dap.configurations.cpp = {
                {
                    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
                    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                    name = "Attach to process",
                    type = "cpp", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
                    request = "attach",
                    pid = require("dap.utils").pick_process,
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
    { -- git integration
        "lewis6991/gitsigns.nvim",
        -- event = 'LazyFile',
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end)

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end)

                -- Actions
                map("n", "<leader>hs", gitsigns.stage_hunk)
                map("n", "<leader>hr", gitsigns.reset_hunk)

                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)

                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)

                map("n", "<leader>hS", gitsigns.stage_buffer)
                map("n", "<leader>hR", gitsigns.reset_buffer)
                map("n", "<leader>hp", gitsigns.preview_hunk)
                map("n", "<leader>hi", gitsigns.preview_hunk_inline)

                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end)
                map("n", "<leader>hB", gitsigns.blame)

                map("n", "<leader>hd", gitsigns.diffthis)

                -- Text object
                map({ "o", "x" }, "ih", gitsigns.select_hunk)
            end,
        },
    },
    {
        "famiu/bufdelete.nvim", -- (archived) preserves window layout when deleting buffers
        keys = {
            { "<leader>d", ":Bdelete<cr>", desc = "Close current buffer" },
        },
    },
    { -- indent guides
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                enabled = false, -- don't underline outer scope
            },
        },
    },
    { -- autopairs
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },

    { -- navigation
        "ggandor/leap.nvim",
        config = function()
            -- Mappings for `x` and `o` modes conflict with `surround` and are unused
            vim.keymap.set("n", "s", "<Plug>(leap-anywhere)")
            -- Disable preview labels
            require("leap").opts.preview_filter = function()
                return false
            end
        end,
    },
})

-------- AUTOCOMMANDS

-- wrap and check for spell in text filetypes (from Lazy)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        -- [List of spelled languages](https://ftp.nluug.nl/pub/vim/runtime/spell)
        --   * [Alternative mirrors](https://www.vim.org/mirrors.php)
        -- Installation directory for spell files : `~/.local/share/nvim/site/spell/`
        -- Issue: [How to deal with "Cannot find word list bg.utf-8.spl or bg.ascii.spl" warning](https://github.com/neovim/neovim/issues/2102)
        --   * Run `nvim -u NORC -c "set spelllang=bg spell"`
        vim.opt_local.spelllang = { "en", "bg" }
    end,
})

-- resize splits if window got resized (from Lazy)
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- define keymaps when lsp is attached
vim.api.nvim_create_autocmd("LspAttach", {
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

        -- use LSP folding is supported by server
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client ~= nil and client:supports_method("textDocument/foldingRange") then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

------- COMMANDS

vim.api.nvim_create_user_command("TNNCopyPath", function(opts)
    local expr = opts.args
    local path = vim.fn.expand(expr)
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, {
    nargs = 1, -- require one argument
    desc = "Copy a file path based on expand() expression",
})

-- Define a command to toggle the keymap
--
-- Note: use `C-v` to insert mapped characters like `[`, `]`, `~`, etc.
vim.api.nvim_create_user_command("TNNToggleKeymap", function()
    if vim.o.iminsert == 1 then
        vim.o.keymap = ""
    else
        vim.o.keymap = "bulgarian-phonetic"
    end
end, {})
