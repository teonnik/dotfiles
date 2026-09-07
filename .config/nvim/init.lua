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
vim.opt.showcmdloc = "statusline" -- render the pending command (`showcmd`) in the statusline via `%S`
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
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Terminal normal mode' })
vim.keymap.set('n', '<leader>c', ':cclose<cr> :lclose<cr> :pclose<cr>', { desc = 'Close quickfix, location and preview windows' })
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
vim.keymap.set("n", "<leader>ut",
    function()
        local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
    { desc = "Remove trailing whitespace (keep cursor)" }
)
vim.keymap.set('n', '<leader>w', ':w!<cr>', { desc = 'Save quickly' })
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor' })
-- Check clipboard support and provider with `:checkhealth`
vim.keymap.set({'n', 'x'}, ',y', '"+y', { desc = 'Copy into clipboard' })
vim.keymap.set({'n', 'x'}, ',p', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set({'n', 'x'}, ',d', '"+d', { desc = 'Cut into clipboard' })
-- stylua: ignore end

------- PLUGINS

-- Rebuild the parsers whenever `nvim-treesitter` itself changes. Has to be
-- registered before `add()` to also fire on the initial install.
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name ~= "nvim-treesitter" or ev.data.kind == "delete" then
            return
        end
        if not ev.data.active then
            vim.cmd.packadd("nvim-treesitter")
        end
        vim.schedule(function()
            vim.cmd("TSUpdate")
        end)
    end,
})

local gh = function(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    -- ui
    { src = gh("catppuccin/nvim"), name = "catppuccin" }, -- colorscheme
    gh("nvim-tree/nvim-web-devicons"), -- icons for `fzf-lua`, `oil` and `lualine`
    gh("nvim-lualine/lualine.nvim"), -- statusline
    gh("lukas-reineke/indent-blankline.nvim"), -- indent guides

    -- editing
    gh("kylechui/nvim-surround"), -- surround selections
    gh("echasnovski/mini.align"), -- align text on delimiters
    gh("windwp/nvim-autopairs"), -- autopairs
    gh("echasnovski/mini.bufremove"), -- preserves the window layout when deleting buffers
    "https://codeberg.org/andyg/leap.nvim", -- navigation

    -- files
    gh("ibhagwan/fzf-lua"), -- fuzzy finder
    gh("stevearc/oil.nvim"), -- file explorer

    -- session and terminal
    gh("stevearc/resession.nvim"), -- session management
    gh("akinsho/toggleterm.nvim"), -- terminal utils

    -- language
    gh("rafamadriz/friendly-snippets"), -- snippet collection for `blink.cmp`
    -- `range("1")` follows the latest `v1` tag, `v2` brings breaking changes
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1") }, -- (auto)-completion
    -- Requires `tree-sitter-cli`, check the status with `:checkhealth nvim-treesitter`
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" }, -- syntax and navigation
    gh("neovim/nvim-lspconfig"), -- language servers
    gh("mfussenegger/nvim-dap"), -- debugging
    gh("theHamsta/nvim-dap-virtual-text"), -- inline debugging info

    -- git
    gh("lewis6991/gitsigns.nvim"), -- git integration
})

------- PLUGIN SETUP

-- colorscheme, applied first so the rest picks up the highlights
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
})
vim.cmd.colorscheme("catppuccin")

-- statusline
require("lualine").setup({
    options = {
        section_separators = "",
        component_separators = "|",
    },
    sections = {
        lualine_b = { "diagnostics" },
        lualine_x = {
            "%S", -- pending command, needs `showcmdloc`
            { -- keymap : https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets
                function()
                    if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
                        return "⌨ " .. vim.b.keymap_name
                    end
                    return ""
                end,
            },
            {
                function()
                    return "󰃃" .. require("resession").get_current()
                end,
                cond = function()
                    return require("resession").get_current() ~= nil
                end,
            },
            "filetype",
        },
    },
})

-- indent guides
require("ibl").setup({
    scope = {
        enabled = false, -- don't underline outer scope
    },
})

-- surround selections
--
-- Drop the normal mode defaults (`ys`, `ds`, `cs`, ...) to free `s` for `leap`, visual `S` and insert `C-g s` are kept
vim.g.nvim_surround_no_normal_mappings = true
require("nvim-surround").setup({})
vim.keymap.set("n", "gz", "<Plug>(nvim-surround-normal)", { desc = "Surround a motion" })
-- The trailing `s` is the `aliases` entry for any delimiter, `nvim-surround` then picks the nearest one
vim.keymap.set(
    "n",
    "gzd",
    "<Plug>(nvim-surround-delete)s",
    { remap = true, desc = "Delete the nearest surrounding pair" }
)

-- align text on delimiters
require("mini.align").setup({
    mappings = { start = "", start_with_preview = "ga" },
})

-- autopairs
require("nvim-autopairs").setup({})

-- preserve the window layout when deleting buffers, plain `:bdelete` closes
-- every window showing the buffer
require("mini.bufremove").setup({})
vim.keymap.set("n", "<leader>d", function()
    require("mini.bufremove").delete()
end, { desc = "Close current buffer" })

-- navigation
vim.keymap.set("n", "s", "<Plug>(leap-anywhere)", { desc = "Leap: jump to a match in any window" })
-- `(leap)` searches the current window only, which is what an operator needs
vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap)", { desc = "Leap: jump to a match in this window" })
-- Disable preview labels
require("leap").opts.preview_filter = function()
    return false
end

-- fuzzy finder
require("fzf-lua").register_ui_select() -- use `fzf-lua` to replace vim.ui.select
-- stylua: ignore start
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'FZF: live grep' })
vim.keymap.set('n', '<leader>.', '<cmd>FzfLua grep_cword<cr>', { desc = 'FZF: grep current word' })
vim.keymap.set('n', '<leader>f', '<cmd>FzfLua files<cr>', { desc = 'FZF: find files' })
vim.keymap.set('n', '<leader>b', '<cmd>FzfLua buffers<cr>', { desc = 'FZF: list buffers' })
vim.keymap.set('n', '<leader>k', '<cmd>FzfLua keymaps<cr>', { desc = 'FZF: list keymaps' })
vim.keymap.set('n', '<leader>sc', '<cmd>FzfLua command_history<cr>', { desc = 'FZF: command history' })
vim.keymap.set('n', '<leader>sr', '<cmd>FzfLua registers<cr>', { desc = 'FZF: list registers' })
vim.keymap.set('n', '<leader>ya', '<cmd>FzfLua lsp_code_actions<cr>', { desc = 'FZF-LSP: code actions' })
vim.keymap.set('n', '<leader>yl', '<cmd>FzfLua lsp_references<cr>', { desc = 'FZF-LSP: references' })
vim.keymap.set('n', '<leader>yg', '<cmd>FzfLua lsp_definitions<cr>', { desc = 'FZF-LSP: definitions' })
vim.keymap.set('n', '<leader>ye', '<cmd>FzfLua lsp_document_diagnostics<cr>', { desc = 'FZF-LSP: diagnostics' })
vim.keymap.set('n', '<leader>ys', '<cmd>FzfLua lsp_document_symbols<cr>', { desc = 'FZF-LSP: document symbols' })
-- stylua: ignore end

-- file explorer
require("oil").setup({
    view_options = {
        show_hidden = true,
    },
    -- keymaps = {
    --   ['y'] = { 'actions.copy_to_system_clipboard', mode = 'n' },
    -- },
})
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open file explorer" })

-- session management
require("resession").setup({
    autosave = { enabled = true, interval = 60, notify = false },
})
-- stylua: ignore start
vim.keymap.set('n', '<leader>qs', function() require('resession').load() end, { desc = 'Restore Session' })
vim.keymap.set('n', '<leader>qw', function() require('resession').save() end, { desc = 'Save Session' })
vim.keymap.set('n', '<leader>qd', function() require('resession').delete() end, { desc = 'Delete Session' })
-- stylua: ignore end

-- terminal utils
require("toggleterm").setup({})
-- Example: `2<C-t>` opens terminal 2
vim.keymap.set("n", "<C-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { desc = "Toggle terminal" })

-- (auto)-completion
require("blink.cmp").setup({
    -- VS Code convention: `Tab` accepts the completion and jumps between snippet placeholders, `C-n`/`C-p` move through the menu
    keymap = {
        preset = "super-tab",
        ["<Esc>"] = { "cancel", "fallback" }, -- dismiss the menu, else leave insert mode
    },
    completion = {
        menu = { auto_show_delay_ms = 300 },
        documentation = { auto_show = true },
        ghost_text = { enabled = true, show_without_menu = false },
    },
    sources = { min_keyword_length = 2 },
    -- `max_typos = 0` requires every typed character to be present in the match, the default allows 1 missing char per 4 typed
    fuzzy = { implementation = "rust", max_typos = 0 },
    signature = { enabled = true },
    cmdline = {
        enabled = true,
        -- `inherit` reuses the keymap above instead of the cmdline default where `Tab` cycles the menu
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
    },
})

-- syntax and navigation
require("nvim-treesitter").install({
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

-- language servers, after `blink.cmp` for `get_lsp_capabilities()`
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Per-project settings belong in a `.clangd` at the repo root, which is also a `root_marker`
for _, server in ipairs({
    "clangd",
    "ty",
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

-- debugging
require("nvim-dap-virtual-text").setup({})

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
vim.keymap.set('n', '<M-c>', function() require('dap').continue() end, { desc = 'DAP: start or continue' })
vim.keymap.set('n', '<M-t>', function() require('dap').terminate() end, { desc = 'DAP: terminate the session' })
vim.keymap.set('n', '<M-right>', function() require('dap').step_over() end, { desc = 'DAP: step over' })
vim.keymap.set('n', '<M-down>', function() require('dap').step_into() end, { desc = 'DAP: step into' })
vim.keymap.set('n', '<M-up>', function() require('dap').step_out() end, { desc = 'DAP: step out' })
vim.keymap.set('n', '<M-f>', function() require('dap').focus_frame() end, { desc = 'DAP: jump to the current frame' })
vim.keymap.set('n', '<M-k>', function() require('dap').up() end, { desc = 'DAP: up one frame' })
vim.keymap.set('n', '<M-j>', function() require('dap').down() end, { desc = 'DAP: down one frame' })
vim.keymap.set('n', '<M-u>', function() require('dap').run_to_cursor() end, { desc = 'DAP: run to cursor' })
vim.keymap.set('n', '<M-b>', function() require('dap').toggle_breakpoint() end, { desc = 'DAP: toggle breakpoint' })
vim.keymap.set('n', '<M-del>', function() require('dap').clear_breakpoints() end, { desc = 'DAP: clear all breakpoints' })
vim.keymap.set('n', '<M-l>', function() require('dap').list_breakpoints() end, { desc = 'DAP: list breakpoints in the quickfix' })
-- In REPL mode LLDB commands can be run by prefixing with ` : e.g. `bt
--
-- https://github.com/mfussenegger/nvim-dap/discussions/381#discussioncomment-2360181
vim.keymap.set('n', '<M-r>', function() require('dap').repl.toggle() end, { desc = 'DAP: toggle the REPL' })
-- stylua: ignore end

-- git integration
require("gitsigns").setup({
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        -- Navigation, fall back to the built-in diff motions in a diff split
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, { buffer = bufnr, desc = "Git: next hunk" })

        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, { buffer = bufnr, desc = "Git: previous hunk" })

        -- Actions
        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Git: stage hunk" })
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Git: reset hunk" })

        vim.keymap.set("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { buffer = bufnr, desc = "Git: stage selected lines" })

        vim.keymap.set("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { buffer = bufnr, desc = "Git: reset selected lines" })

        vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { buffer = bufnr, desc = "Git: stage buffer" })
        vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Git: reset buffer" })
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Git: preview hunk" })
        vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline, { buffer = bufnr, desc = "Git: inline hunk" })

        vim.keymap.set("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end, { buffer = bufnr, desc = "Git: blame current line" })
        vim.keymap.set("n", "<leader>hB", gitsigns.blame, { buffer = bufnr, desc = "Git: blame buffer" })

        vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr, desc = "Git: diff against index" })

        -- Text object
        vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, { buffer = bufnr, desc = "Git: select hunk" })
    end,
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

-- Nvim 0.13 ships `:packupdate` and `:packdel`, at which point these can go
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Pack: fetch updates and open the confirmation buffer" })

vim.api.nvim_create_user_command("PackStatus", function()
    vim.pack.update(nil, { offline = true })
end, { desc = "Pack: list installed plugins without fetching" })

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
