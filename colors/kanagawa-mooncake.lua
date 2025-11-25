-- Kanagawa Dragon for mini.base16 with transparent background
-- Requires: echasnovski/mini.base16

local palette = {
    base00 = "#1a1818",
    base01 = "#282727",
    base02 = "#727169",
    base03 = "#727169",
    base04 = "#c8c093",
    base05 = "#a6a69c",
    base06 = "#8ba4b0",
    base07 = "#a6a69c",
    base08 = "#c4b28a",
    base09 = "#b6927b",
    base0A = "#8ea4a2",
    base0B = "#8a9a7b",
    base0C = "#8ba4b0",
    base0D = "#8ba4b0",
    base0E = "#a292a3",
    base0F = "#a6a69c",
}


require("mini.base16").setup({
    palette = palette,
    use_cterm = true,
    transparent = true,
    plugins = {
        default = true,
    }
})


-- Transparent backgrounds using Lua API
local function set_transparent(groups)
    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
end


-- set_transparent({
--     "Normal",
--     "NormalFloat",
--     "TelescopeNormal"
-- })
