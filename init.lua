-- Global
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.guifont = 'JetBrainsMono NF'
vim.g.have_nerd_font = true

-- vim.g.indent_guide = true

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
vim.o.signcolumn = "yes"
vim.o.mouse = 'a'
vim.o.cursorline = true
vim.o.colorcolumn = '120'
vim.o.scrolloff = 10
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', leadmultispace = "»   " }
-- Misc
vim.o.swapfile = false
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
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 20

-- save Folds
local group = vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    callback = function()
        local ft = vim.bo.filetype
        if ft ~= "TelescopePrompt" and vim.bo.buftype == "" then
            vim.cmd("silent! mkview")
        end
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function()
        local ft = vim.bo.filetype
        if ft ~= "TelescopePrompt" and vim.bo.buftype == "" then
            vim.cmd("silent! loadview")
        end
    end,
})
-- diagnostic
vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = { -- sing
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

-- Highlight yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.pack.add({
    -- Visual
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    -- Trees
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/stevearc/oil.nvim" },
    -- ( auto completion )/highlight
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/saghen/blink.cmp" },
    -- Mini Text editing
    { src = "https://github.com/echasnovski/mini.ai" },
    { src = "https://github.com/echasnovski/mini.surround" },
    { src = "https://github.com/echasnovski/mini.pairs" },
    { src = "https://github.com/echasnovski/mini.move" },
    { src = "https://github.com/echasnovski/mini.splitjoin" },
    { src = "https://github.com/echasnovski/mini.operators" },
    -- Mini Workflow
    { src = "https://github.com/echasnovski/mini.bracketed" },
    -- Mini Appearance
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/echasnovski/mini.statusline" },
    { src = "https://github.com/echasnovski/mini.indentscope" },
    { src = "https://github.com/echasnovski/mini.hipatterns" },
    -- Telescope
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
    -- Navigation
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    -- Preview
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/OXY2DEV/markview.nvim" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    -- Misc
    { src = "https://github.com/lambdalisue/vim-suda" },
})

-- colorscheme
require("kanagawa").setup({
    transparent = true,
    background = {       -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "dragon"
    },
    terminalColors = true,
    overrides = function(colors)
        local theme = colors.theme
        return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
    end,
})
vim.cmd.colorscheme("kanagawa")

-- setup plugin
for _, v in pairs(vim.pack.get()) do
    if v.spec.name == "telescope-fzf-native.nvim" then
        local fzf_path = v.path
        if not vim.loop.fs_stat(fzf_path .. "/build") then
            vim.fn.system({ "make", "-C", fzf_path })
        end
    end
end

-- Mini
require "mini.ai".setup()
require "mini.icons".setup()
require "mini.surround".setup()
require "mini.statusline".setup()
require "mini.pairs".setup()
require "mini.move".setup()
require "mini.splitjoin".setup()
require 'mini.operators'.setup()
require 'mini.bracketed'.setup()
require 'mini.hipatterns'.setup({
    highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        hex_color = require 'mini.hipatterns'.gen_highlighter.hex_color(),
    },
})
require('mini.indentscope').setup({
    draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.none(),
    },
    symbol = '▎',
})
-- Icons
require "nvim-web-devicons".setup()
-- Preview
require "typst-preview".setup()
require "markview".setup({
    preview = {
        icon_provider = "mini", -- "mini" or "devicons"
    }
})

--- file explorer
require "oil".setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    }
})

-- which-key
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
})

-- (auto completion)/highlight
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

require "blink.cmp".setup({
    completion = {
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = true }, },
        ghost_text = { enabled = true },
        documentation = { auto_show = true, auto_show_delay_ms = 000 },
        menu = {
            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind" }
                },
            }
        }
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    signature = { enabled = true },
    fuzzy = { implementation = "lua" }
})

local rg = {
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
    '--glob=!**/*.uid',
    '--glob=!**/flake.lock',
    '--glob=!**/package-lock.json',
}

require('telescope').setup {
    defaults = {
        winblend = 0,
        file_ignore_patterns = {
            '*.import',
        },
        vimgrep_arguments = {
        },
    },
    pickers = {
        find_files = {
            hidden = true,
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
                '--glob=!**/*.uid',
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

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(event)
        -- Use LSP formatting
        vim.lsp.buf.format({
            async = true,
            bufnr = event.buf
        })
    end,
})

-- LSP map + inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        -- inlay hints
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
        end

        -- maps
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

require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = {
        enable = true,
    },
})

-- LPS
local capabilities = require('blink.cmp').get_lsp_capabilities()
require "mason".setup()
require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = false,
    handlers = {
        function(server_name)
            local server = vim.lsp.config[server_name] or {}

            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config[server_name] = server
        end,
    },
}

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
    io.close(gdproject)
    -- vim.fn.serverstart './godothost'
    vim.lsp.enable("gdscript")
end


local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = desc })
end
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>u', ':update<CR> :source<CR>', "[U]pdate config")
map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", "Navigate Left (tmux)")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", "Navigate Down (tmux)")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", "Navigate Up (tmux)")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", "Navigate Right (tmux)")
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", "Navigate Previous (tmux)")

map({ 'n', 'v', 'x' }, '<leader>y', '"+y', "[Y]anking Global")
map({ 'n', 'v', 'x' }, '<leader>p', '"+p', "[P]asting Global")
map('n', '<leader>tb', ":%!xxd -r<CR>", "[B]inary")
map('n', '<leader>th', ":%!xxd<CR>", "[H]ex")
map('n', '<leader>te', ":Oil<CR>", "Open [E]xplorer")
map('n', '<leader>tu', vim.cmd.UndotreeToggle, "Open [U]undotree")
map('n', '<leader>tt', ":TypstPreview<CR>", "[T]ypstPreview")
map('n', '<leader>tm', ":Markview Toggle<CR>", "[M]arkview")

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
