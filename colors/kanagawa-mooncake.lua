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
    plugins = {
        default = true,
        ['nvim-telescope/telescope.nvim'] = false,
    }

})

local hl = vim.api.nvim_set_hl

-- Menu styling
hl(0, "BlinkCmpMenu", { fg = palette.base05, bg = palette.base00 })
hl(0, "BlinkCmpMenuBorder", { fg = palette.base04, bg = palette.base00 })
hl(0, "BlinkCmpMenuSelection", { fg = palette.base04, bg = palette.base04 })
hl(0, "BlinkCmpScrollBarThumb", { fg = palette.base04, bg = palette.base00 })
hl(0, "BlinkCmpScrollBarGutter", { fg = palette.base00, bg = palette.base00 })

-- Labels and details
hl(0, "BlinkCmpLabel", { fg = palette.base05 })
hl(0, "BlinkCmpLabelDeprecated", { fg = palette.base08, strikethrough = true })
hl(0, "BlinkCmpLabelMatch", { fg = palette.base0D }) -- Currently unused but styled
hl(0, "BlinkCmpLabelDetail", { fg = palette.base06 })
hl(0, "BlinkCmpLabelDescription", { fg = palette.base06 })


-- Kind icons and source
hl(0, "BlinkCmpKind", { fg = palette.base0D })
hl(0, "BlinkCmpKindFunction", { fg = palette.base0A })      -- Function kind
hl(0, "BlinkCmpKindVariable", { fg = palette.base08 })      -- Variable kind
hl(0, "BlinkCmpKindClass", { fg = palette.base0A })         -- Class kind
hl(0, "BlinkCmpKindModule", { fg = palette.base0E })        -- Module kind
hl(0, "BlinkCmpKindMethod", { fg = palette.base0B })        -- Method kind
hl(0, "BlinkCmpKindProperty", { fg = palette.base08 })      -- Property kind
hl(0, "BlinkCmpKindField", { fg = palette.base08 })         -- Field kind
hl(0, "BlinkCmpKindConstructor", { fg = palette.base0A })   -- Constructor kind
hl(0, "BlinkCmpKindEnum", { fg = palette.base0A })          -- Enum kind
hl(0, "BlinkCmpKindInterface", { fg = palette.base0A })     -- Interface kind
hl(0, "BlinkCmpKindStruct", { fg = palette.base0A })        -- Struct kind
hl(0, "BlinkCmpKindEvent", { fg = palette.base0E })         -- Event kind
hl(0, "BlinkCmpKindOperator", { fg = palette.base0D })      -- Operator kind
hl(0, "BlinkCmpKindTypeParameter", { fg = palette.base0A }) -- Type Parameter kind
hl(0, "BlinkCmpSource", { fg = palette.base0E })

-- Ghost text
hl(0, "BlinkCmpGhostText", { fg = palette.base03 })


-- Documentation window
hl(0, "BlinkCmpDoc", { fg = palette.base05, bg = palette.base01 })
hl(0, "BlinkCmpDocBorder", { fg = palette.base04, bg = palette.base01 })
hl(0, "BlinkCmpDocSeparator", { fg = palette.base04, bg = palette.base01 })
hl(0, "BlinkCmpDocCursorLine", { bg = palette.base02 })

-- Signature help
hl(0, "BlinkCmpSignatureHelp", { fg = palette.base05, bg = palette.base01 })
hl(0, "BlinkCmpSignatureHelpBorder", { fg = palette.base04, bg = palette.base01 })
hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = palette.base00, bg = palette.base0D })
