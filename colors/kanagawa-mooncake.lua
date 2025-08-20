-- Kanagawa Dragon for mini.base16 with transparent background
-- Requires: echasnovski/mini.base16

local palette = {
    base00 = "#1A1818",
    base01 = "#282727",
    base02 = "#727169",
    base03 = "#727169",
    base04 = "#C8C093",
    base05 = "#A6A69C",
    base06 = "#8BA4B0",
    base07 = "#AaC093",
    base08 = "#C4B28A",
    base09 = "#B6927B",
    base0A = "#8EA4A2",
    base0B = "#8A9A7B",
    base0C = "#8BA4B0",
    base0D = "#8BA4B0",
    base0E = "#A292A3",
    base0F = "#C5C9C5"
}

require("mini.base16").setup({
    palette = palette,
    use_cterm = true,
    plugins = { default = true }
})

-- Keep background transparent (also after :colorscheme)
local none = { bg = "none" }
local groups = {
    "Normal",
    "NormalNC",
    -- "NormalFloat",
    -- "SignColumn",
    -- "EndOfBuffer",
    -- "FloatBorder",
    -- "WinSeparator",
    -- "MsgArea",
    -- common plugin groups (ignore if you don’t use them)
    "TelescopeNormal",
    "TelescopeBorder",
    "NvimTreeNormal",
    "NvimTreeEndOfBuffer"
}
for _, g in ipairs(groups) do
    pcall(vim.api.nvim_set_hl, 0, g, none)
end
