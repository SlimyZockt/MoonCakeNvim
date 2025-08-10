-- Global
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.guifont = 'JetBrainsMono Nerd Font'
vim.g.have_nerd_font = true
vim.g.indent_guide = true

-- Enable break indent
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Visual
vim.o.cursorcolumn = false
vim.o.wrap = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.incsearch = true
vim.o.signcolumn = "yes"
vim.o.mouse = 'a'
vim.o.cursorline = true
vim.o.colorcolumn = '120'
vim.o.scrolloff = 10

-- Misc
vim.o.swapfile = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.showmode = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.confirm = true
-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- spell
vim.o.spell = true
vim.o.spelllang = 'en_us,de_de'

-- Add better fold support
vim.o.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 2
vim.opt.foldnestmax = 2

vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    },
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}


vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.pack.add({
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/echasnovski/mini.ai" },
    { src = "https://github.com/echasnovski/mini.surround" },
    { src = "https://github.com/echasnovski/mini.statusline" },
    { src = "https://github.com/echasnovski/mini.pairs" },
    { src = "https://github.com/echasnovski/mini.move" },
    { src = "https://github.com/echasnovski/mini.splitjoin" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/lambdalisue/vim-suda" },
    { src = "https://github.com/saghen/blink.indent" },
})

for _, v in pairs(vim.pack.get()) do
    if v.spec.name == "telescope-fzf-native.nvim" then
        local fzf_path = v.path
        if not vim.loop.fs_stat(fzf_path .. "/build") then
            vim.fn.system({ "make", "-C", fzf_path })
        end
    end
end

require "mason".setup()
require "mini.ai".setup()
require "mini.icons".setup()
require "mini.surround".setup()
require "mini.statusline".setup()
require "mini.pairs".setup()
require "mini.move".setup()
require "mini.splitjoin".setup()
require 'nvim-web-devicons'.setup()


require "blink.indent".setup {
    blocked = {
        buftypes = {},
        filetypes = {},
    },
    static = {
        enabled = true,
        char = '▎',
        priority = 1,
        highlights = { 'BlinkIndent' },
    },
    scope = {
        enabled = true,
        char = '▎',
        priority = 1024,
        -- set this to a single highlight, such as 'BlinkIndent' to disable rainbow-style indent guides
        highlights = { 'BlinkIndent' },
        underline = {
            enabled = false,
        },
    },
}

require("kanagawa").setup({
    transparent = true,
    background = {       -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus"
    },
    terminalColors = true,
    overrides = function(colors)
        local theme = colors.theme
        return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
        }
    end,
})

vim.cmd.colorscheme("kanagawa")
vim.cmd(":hi statusline guibg=NONE")
vim.cmd([[
  highlight TelescopeNormal guibg=NONE
  highlight TelescopeBorder guibg=NONE
  highlight TelescopePromptNormal guibg=NONE
  highlight TelescopePromptBorder guibg=NONE
  highlight TelescopeResultsNormal guibg=NONE
  highlight TelescopeResultsBorder guibg=NONE
  highlight TelescopePreviewNormal guibg=NONE
  highlight TelescopePreviewBorder guibg=NONE
]])


require 'treesitter-context'.setup {
    enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
    multiwindow = false,      -- Enable multiwindow support.
    max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20,     -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        require "which-key".setup({
            icons = {
                mappings = vim.g.have_nerd_font,
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down> ',
                    Left = '<Left> ',
                    Right = '<Right> ',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },

            spec = {
                { '<leader>c', group = '[C]ode',    mode = { 'n', 'x' } },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
            },

            windows = {
                position = "bottom",
                winblend = 0,
                width = vim.o.columns,
            },

        }
        )
    end
})

require "oil".setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    }
})

require "blink.cmp".setup({
    completion = {
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = true }, },
        ghost_text = { enabled = true },
        documentation = { auto_show = true, auto_show_delay_ms = 000 },
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    signature = { enabled = true },

    fuzzy = { implementation = "lua" }
})

require('telescope').setup {
    defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        winblend = 0,
        file_ignore_patterns = {
            '*.import',
        },

        vimgrep_arguments = {
            'rg',
            '--follow',        -- Follow symbolic links
            '--hidden',        -- Search for hidden files
            '--no-heading',    -- Don't group matches by each file
            '--with-filename', -- Print the file path with the matched lines
            '--line-number',   -- Show line numbers
            '--column',        -- Show column numbers
            '--smart-case',    -- Smart case search

            -- Exclude some patterns from search
            '--glob=!**/.git/*',
            '--glob=!**/.idea/*',
            '--glob=!**/.vscode/*',
            '--glob=!**/.godot/*',
            '--glob=!**/build/*',
            '--glob=!**/dist/*',
            '--glob=!**/yarn.lock',
            '--glob=!**/*.import',
            '--glob=!**/flake.lock',
            '--glob=!**/package-lock.json',
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            -- needed to exclude some files & dirs from general search
            -- when not included or specified in .gitignore
            find_command = {
                'rg',
                '--files',
                '--hidden',
                '--glob=!**/.git/*',
                '--glob=!**/.idea/*',
                '--glob=!**/.godot/*',
                '--glob=!**/.vscode/*',
                '--glob=!**/build/*',
                '--glob=!**/dist/*',
                '--glob=!**/yarn.lock',
                '--glob=!**/*.import',
                '--glob=!**/flake.lock',
                '--glob=!**/package-lock.json',
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
    },

}

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')


vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(event)
        -- Use LSP formatting
        vim.lsp.buf.format({
            async = true,
            bufnr = event.buf
        })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end


        local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
        end

        local builtin = require 'telescope.builtin'

        map('n', 'gd', builtin.lsp_definitions, '[G]oto [D]efinition')
        map('n', 'gr', builtin.lsp_references, '[G]oto [R]eferences')
        map('n', 'gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
        map('n', '<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
        map('n', '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
        map('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    end,
})

vim.lsp.enable({
    "lua_ls",
    "svelte",
    "tinymist",
    "emmetls",
    "gopls",
    "ols",
    "rust_analyzer",
    "emmet_language_server",
    "htmx",
    "astro",
    "pyright",
    "tailwind",
    "emmet_language_server",
    "html",
    "eslint",
    "clangd",
    "zls",
    "tl_ls",
    "dockerls",
    "templ",
    "markdown_oxide",
})

local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = desc })
end

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>u', ':update<CR> :source<CR>', "[U]pdate config")
map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')
map('n', '<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('n', '<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('n', '<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('n', '<C-k>', '<C-w><C-k>', 'Move focus to the upper window')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y', "[Y]anking Global")
map('n', '<leader>te', ":Oil<CR>", "Open [E]xplorer")
map('n', '<leader>tu', vim.cmd.UndotreeToggle, "Open [U]undotree")
map('n', '<leader>f', vim.lsp.buf.format, "[F]ormat")

local builtin = require 'telescope.builtin'
map('n', '<leader>sh', builtin.help_tags, '[S]earch [H]elp')
map('n', '<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
map('n', '<leader>sf', builtin.find_files, '[S]earch [F]iles')
map('n', '<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
map('n', '<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
map('n', '<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
map('n', '<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
map('n', '<leader>sr', builtin.resume, '[S]earch [R]esume')
map('n', '<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
map('n', '<leader><leader>', builtin.buffers, '[ ] Find existing buffers')
map('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
    })
end, '[/] Fuzzily search in current buffer')



map('n', '<leader>s/', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end, '[S]earch [/] in Open Files')



require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = {
        enable = true,
    },
})
