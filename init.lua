-- Global
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.guifont = 'JetBrainsMono NF'
vim.g.have_nerd_font = true

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
vim.o.inccommand = 'split'
-- Misc
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.showmode = false
vim.o.undofile = true
vim.o.smartcase = true
vim.o.timeoutlen = 300
vim.o.confirm = false
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.path = "**"
-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
-- spell
vim.o.spell = true
vim.o.spelllang = 'en_us,de_de'
-- folds
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.viewoptions = "cursor,curdir,folds"


if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.g.neovide_opacity = 0.9
    vim.g.neovide_normal_opacity = 0.9
    -- vim.g.neovide_refresh_rate = 140
    -- vim.cmd("highlight Normal guibg=#")

    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', { noremap = true })
    vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', { noremap = true })
    vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', { noremap = true })
    vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
    vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>l"+Pli', { noremap = true })
    vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', { noremap = true })

    vim.api.nvim_create_autocmd('UIEnter', {
        callback = function()
            vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1818" })
        end
    })
end


vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
    pattern = { "*.*" },
    desc = "Save view (folds) when closing file",
    command = "mkview"
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "*.*" },
    desc = "Load view (folds) when opening file",
    command = "silent! loadview"
})

vim.cmd(":command! -nargs=+ Grep execute 'silent grep! <args>' | copen")
vim.cmd(":packadd nvim.undotree")

-- Ctags
vim.g.tags = vim.fn.stdpath('config') .. '/system_tags,tags'
vim.o.omnifunc = "syntaxcomplete#Complete"

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
    -- Misc
    { src = "https://github.com/kevinhwang91/promise-async" },
    -- Visual
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    -- Trees
    -- { src = "nvim.undotree" },
    { src = "https://github.com/stevearc/oil.nvim" },
    -- ( auto completion )/highlight
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/ej-shafran/compile-mode.nvim" },
    -- Mini Text editing
    { src = "https://github.com/nvim-mini/mini.ai" },
    { src = "https://github.com/nvim-mini/mini.surround" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/nvim-mini/mini.move" },
    { src = "https://github.com/nvim-mini/mini.splitjoin" },
    { src = "https://github.com/nvim-mini/mini.operators" },
    -- Mini Workflow
    { src = "https://github.com/nvim-mini/mini.bracketed" },
    { src = "https://github.com/nvim-mini/mini.jump" },
    -- { src = "https://github.com/nvim-mini/mini.snippets" },
    -- Mini Appearance
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-mini/mini.statusline" },
    { src = "https://github.com/nvim-mini/mini.indentscope" },
    { src = "https://github.com/nvim-mini/mini.hipatterns" },
    { src = "https://github.com/SlimyZockt/mini.base16" },
    -- Telescope
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
    -- Navigation
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/kevinhwang91/nvim-ufo" },
    -- Preview
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
    { src = "https://github.com/OXY2DEV/markview.nvim" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    -- Sudo files
    { src = "https://github.com/lambdalisue/vim-suda" },
    -- Wiki
    { src = "https://github.com/vimwiki/vimwiki" },
})

vim.cmd.colorscheme "kanagawa-mooncake"

-- setup plugin
for _, v in pairs(vim.pack.get()) do
    if v.spec.name == "telescope-fzf-native.nvim" then
        local fzf_path = v.path
        if not vim.loop.fs_stat(fzf_path .. "/build") then
            vim.fn.system({ "make", "-C", fzf_path })
        end
    end
end

vim.g.compile_mode = {
    -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
    -- set this to fix tab completion in command mode:
    input_word_completion = true,
    default_command = {
        c = "make -k",
        cpp = "make -k",
        go = "go run .",
        odin = "odin run ."
    },

    -- to add ANSI escape code support, add:
    -- baleia_setup = true,

    -- to make `:Compile` replace special characters (e.g. `%`) in
    -- the command (and behave more like `:!`), add:
    -- bang_expansion = true,
    use_circular_error_navigation = true,
}



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
require 'mini.jump'.setup()
-- require 'mini.jump2d'.setup()
-- local gen_loader = require('mini.snippets').gen_loader
require 'mini.hipatterns'.setup {
    highlighters = {
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        hex_color = require 'mini.hipatterns'.gen_highlighter.hex_color(),
    },
}
require 'mini.indentscope'.setup {
    draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.none(),
    },
    -- symbol = '▎',
    symbol = '»',
}
-- Icons
require "nvim-web-devicons".setup()
-- Preview
require "toggleterm".setup {
    persist_size = false,
    size = vim.o.columns * 0.5,
    direction = "vertical",
}
require "typst-preview".setup()
require "markview".setup {
    preview = {
        icon_provider = "mini", -- "mini" or "devicons"
    }
}

--- file explorer
require "oil".setup {
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
    confirmation = {
        border = "single",
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

-- which-key
require "which-key".setup {
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

require('nvim-treesitter').setup {
    auto_install = true,
    folds = { enabled = true },
}

-- (auto completion)/highlight
require 'treesitter-context'.setup {
    separator = '─',
}


-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(event)
        -- Use LSP formatting
        vim.lsp.buf.format {
            async = false,
            bufnr = event.buf
        }
    end,
})

require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
    end
})

require "blink.cmp".setup {
    cmdline = { enabled = false },
    completion = {
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = true }, },
        ghost_text = { enabled = true },
        documentation = { auto_show = true, auto_show_delay_ms = 000 },
    },
    appearance = {
        nerd_font_variant = 'mono'
    },
    sources = {
        default = { 'lsp', 'path', 'buffer', 'snippets' },
        per_filetype = {
            c = { inherit_defaults = true, 'omni' }
        },
    },
    snippets = { preset = 'default' },
    signature = { enabled = true },
    fuzzy = { implementation = "lua" }
}


require('telescope').setup {
    defaults = {
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
require 'telescope'.load_extension 'fzf'
require 'telescope'.load_extension 'ui-select'

-- LSP map + inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        -- inlay hints
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                hint = {
                    enable = true,
                },
            },
        },
    },
    svelte = {},
    tinymist = {},
    gopls = {
        settings = {
            gopls = {
                hints = {
                    rangeVariableTypes = true,
                    parameterNames = true,
                    constantValues = true,
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    functionTypeParameters = true,
                },
            },
        },

    },
    ts_ls = {},
    ols = {
        init_options = {
            enable_inlay_hints_params = false,
            enable_inlay_hints_default_params = false,
            enable_inlay_hints_implicit_return = true,

            enable_fake_methods = true,
            enable_overload_resolution = true,
            enable_snippets = true,
            enable_procedure_snippet = true,
            enable_auto_import = true,
            enable_comp_lit_signature_help = true,
            enable_comp_lit_signature_help_use_docs = true,
            enable_semantic_tokens = true,
            enable_code_action_invert_if = true,

            enable_checker_only_saved = true,
            checker_args = '-strict-style -vet',
            verbose = false,
        },
    },
    rust_analyzer = {},
    htmx = {
        filetypes = { 'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ', },
    },
    -- astro = {},
    pyright = {},
    tailwindcss = {
        filetypes = { 'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'htmlangular', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte', 'templ', },
    },
    emmet_language_server = { 'astro', 'css', 'eruby', 'html', 'htmlangular', 'htmldjango', 'javascriptreact', 'less', 'pug', 'sass', 'scss', 'svelte', 'templ', 'typescriptreact', 'vue', },
    html = { filetypes = { 'html', 'templ', 'javascriptreact', 'typescriptreact' }, },
    zls = {
        settings = {
            enable_argument_placeholders = false,
        }
    },
    jdtls = {
        root_markers = {
            'settings.gradle',
            'settings.gradle.kts',
            'pom.xml',
            'build.gradle',
            'mvnw',
            'gradlew',
            'build.gradle',
            'build.gradle.kts',

            -- '.git',
        },
    },
    -- clangd = {},
    templ = {},
    markdown_oxide = {},
}



-- LPS
local server_list = vim.tbl_keys(servers or {})
local capabilities = require('blink.cmp').get_lsp_capabilities()

for server_name, server_opts in pairs(servers) do
    -- Ensure server_opts is a table
    server_opts = server_opts or {}

    -- Merge capabilities
    server_opts.capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        server_opts.capabilities or {}
    )

    -- Specifically for 'ols', ensure init_options is passed correctly
    -- Many LSPs (like ols) prefer 'init_options' over 'settings'
    vim.lsp.config(server_name, server_opts)
end
vim.lsp.enable(server_list)
require "mason".setup()

require("mason-lspconfig").setup {
    ensure_installed = server_list,
    automatic_enable = false,
}

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
    io.close(gdproject)
    vim.lsp.enable("gdscript")
end

local map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = desc })
end
map('n', '<Esc>', function()
    vim.cmd.nohlsearch()
    vim.snippet.stop()
end)

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
    builtin.current_buffer_fuzzy_find(require 'telescope.themes'.get_dropdown {
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
map('n', 'gd', builtin.lsp_definitions, '[G]oto [D]efinition')
map('n', 'gr', builtin.lsp_references, '[G]oto [R]eferences')
map('n', 'gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
map('n', '<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
map('n', '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
map('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

map('n', 'M', ":Man <CR>", "[M]an page")
map('n', '<leader>u', ':update<CR> :source<CR>', "[U]pdate config")
map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", "Navigate Left (tmux)")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", "Navigate Down (tmux)")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", "Navigate Up (tmux)")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", "Navigate Right (tmux)")
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", "Navigate Previous (tmux)")

vim.keymap.set("n", "<S-O>", "O<ESC>")

map("n", "<C-n>", ":cnext<CR>", "Quick Fix next")
map("n", "<C-p>", ":cprev<CR>", "Quick Fix previous")

map("n", "<A-n>", function()
    vim.diagnostic.jump({ count = 1 })
end, "Diagnostic next")

map("n", "<A-p>", function()
    vim.diagnostic.jump({ count = -1 })
end, "Diagnostic previous")

map('n', '<leader>e', ":resize 18<CR>", "r[e]size")
map('n', '<leader>cc', ":below Compile<CR>", "[C]ompile")
map('n', '<leader>cr', ":below Recompile<CR>", "[R]ecompile")

map('n', '<leader>x', ":copen<CR>", "Qui[X] fix list")
map('n', '<leader>c', ":!ctags -R .<CR>", "Generate [c]tags")

map('n', '<leader>ff', ":find ", "find files")
map('n', '<leader>fg', ":Grep ", "grep")

map('t', '<ESC>', "<C-\\><C-n>", "")

map('n', '<leader>f', vim.lsp.buf.format, "[F]ormat")
map("n", "zK", require("ufo").peekFoldedLinesUnderCursor, "Peek fold (ufo)")

map({ 'n', 'v', 'x' }, '<leader>y', '"+y', "[Y]anking Global")
map({ 'n', 'v', 'x' }, '<leader>p', '"+p', "[P]asting Global")

map({ 'n', 'v', 'x' }, '<leader>y', '"+y', "[Y]anking Global")
map({ 'n', 'v', 'x' }, '<leader>p', '"+p', "[P]asting Global")
map('n', '<leader>tb', ":%!xxd -r<CR>", "[B]inary")
map('n', '<leader>th', ":%!xxd<CR>", "[H]ex")
map('n', '<leader>te', ":Oil<CR>", "Open [E]xplorer")
map('n', '<leader>tu', function()
    require('undotree').open({
        command = 'leftabove 40vnew',
    })
    -- Move to rightmost position
    -- vim.cmd('wincmd L')
end, "Open [U]undotree")

map('n', '<leader>ty', ":TypstPreview<CR>", "T[y]pstPreview")
map('n', '<leader>tt', ":ToggleTerm<CR>", "[T]erminal")
map('n', '<leader>tm', ":Markview Toggle<CR>", "[M]arkview")
