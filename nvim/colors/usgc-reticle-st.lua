-- USGC-RETICLE-ST colorscheme for Neovim
-- Converted from Sublime Text color scheme

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "usgc-reticle-st"
vim.o.termguicolors = true
vim.o.background = "dark"

-- Palette (from Sublime variables)
local c = {
  black       = "#000000",
  white       = "#FFFFFF",
  fl_red      = "#FF0000",
  fl_green    = "#00FF00",
  fl_blue     = "#0000FF",
  fl_cyan     = "#00FFFF",
  fl_magenta  = "#FF00FF",
  fl_yellow   = "#FFFF00",
  fl_orange   = "#FF6600",
  maroon      = "#660000",
  green       = "#00A645",
  blue        = "#000066",
  cyan        = "#006666",
  magenta     = "#660066",
  yellow      = "#FFBF00",
  olive       = "#666600",
  gray        = "#999999",
  -- Derived / extra shades for completeness
  dark_gray   = "#333333",
  mid_gray    = "#666666",
  light_green = "#33CC66",
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ============================================================================
-- Editor UI (from globals)
-- ============================================================================
hi("Normal",         { fg = c.green,    bg = c.black })
hi("NormalFloat",    { fg = c.green,    bg = "#0A0A0A" })
hi("FloatBorder",    { fg = c.green,    bg = "#0A0A0A" })
hi("Cursor",         { fg = c.black,    bg = c.white })
hi("CursorLine",     { bg = c.fl_blue })
hi("CursorLineNr",   { fg = c.white,    bg = c.fl_blue, bold = true })
hi("LineNr",         { fg = c.fl_red,   bg = c.black })
hi("Visual",         { fg = c.fl_blue,  bg = c.white })
hi("VisualNOS",      { fg = c.fl_blue,  bg = c.gray })
hi("Search",         { fg = c.black,    bg = c.fl_yellow })
hi("IncSearch",      { fg = c.black,    bg = c.fl_orange })
hi("CurSearch",      { fg = c.black,    bg = c.fl_orange })
hi("Substitute",     { fg = c.black,    bg = c.fl_yellow })

hi("StatusLine",     { fg = c.green,    bg = "#111111" })
hi("StatusLineNC",   { fg = c.gray,     bg = "#0A0A0A" })
hi("WinSeparator",   { fg = c.mid_gray, bg = c.black })
hi("VertSplit",      { fg = c.mid_gray, bg = c.black })
hi("TabLine",        { fg = c.gray,     bg = "#111111" })
hi("TabLineFill",    { bg = "#0A0A0A" })
hi("TabLineSel",     { fg = c.green,    bg = c.black, bold = true })

hi("Pmenu",          { fg = c.green,    bg = "#0A0A0A" })
hi("PmenuSel",       { fg = c.fl_blue,  bg = c.white })
hi("PmenuSbar",      { bg = "#111111" })
hi("PmenuThumb",     { bg = c.gray })

hi("Folded",         { fg = c.gray,     bg = "#111111" })
hi("FoldColumn",     { fg = c.gray,     bg = c.black })
hi("SignColumn",     { fg = c.green,    bg = c.black })
hi("ColorColumn",    { bg = "#0A0A0A" })

hi("MatchParen",     { fg = c.fl_magenta, bg = c.dark_gray, bold = true })
hi("NonText",        { fg = c.dark_gray })
hi("SpecialKey",     { fg = c.dark_gray })
hi("Whitespace",     { fg = c.dark_gray })
hi("EndOfBuffer",    { fg = c.dark_gray })

hi("Directory",      { fg = c.fl_cyan })
hi("Title",          { fg = c.fl_cyan, bold = true })
hi("Question",       { fg = c.fl_green })
hi("MoreMsg",        { fg = c.fl_green })
hi("ModeMsg",        { fg = c.white, bold = true })
hi("WildMenu",       { fg = c.black, bg = c.fl_yellow })

-- Diagnostics
hi("ErrorMsg",       { fg = c.fl_red, bold = true })
hi("WarningMsg",     { fg = c.fl_orange, bold = true })
hi("DiagnosticError",{ fg = c.fl_red })
hi("DiagnosticWarn", { fg = c.fl_orange })
hi("DiagnosticInfo", { fg = c.fl_cyan })
hi("DiagnosticHint", { fg = c.gray })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.fl_red })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.fl_orange })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.fl_cyan })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = c.gray })

-- Diff
hi("DiffAdd",        { fg = c.fl_green,  bg = "#002200" })
hi("DiffChange",     { fg = c.fl_yellow, bg = "#222200" })
hi("DiffDelete",     { fg = c.fl_red,    bg = "#220000" })
hi("DiffText",       { fg = c.fl_yellow, bg = "#444400", bold = true })

-- Spell
hi("SpellBad",       { undercurl = true, sp = c.fl_red })
hi("SpellCap",       { undercurl = true, sp = c.fl_blue })
hi("SpellRare",      { undercurl = true, sp = c.fl_magenta })
hi("SpellLocal",     { undercurl = true, sp = c.fl_cyan })

-- ============================================================================
-- Syntax highlighting
-- ============================================================================
hi("Comment",        { fg = c.gray, italic = true })

hi("Constant",       { fg = c.fl_cyan })
hi("String",         { fg = c.fl_yellow })
hi("Character",      { fg = c.fl_yellow })
hi("Number",         { fg = c.fl_magenta })
hi("Boolean",        { fg = c.fl_magenta })
hi("Float",          { fg = c.fl_magenta })

hi("Identifier",     { fg = c.green })
hi("Function",       { fg = c.light_green })

hi("Statement",      { fg = c.fl_red, bold = true })
hi("Conditional",    { fg = c.fl_red })
hi("Repeat",         { fg = c.fl_red })
hi("Label",          { fg = c.fl_orange })
hi("Operator",       { fg = c.white })
hi("Keyword",        { fg = c.fl_red, italic = true })
hi("Exception",      { fg = c.fl_red })

hi("PreProc",        { fg = c.fl_orange })
hi("Include",        { fg = c.fl_orange })
hi("Define",         { fg = c.fl_orange })
hi("Macro",          { fg = c.fl_orange })
hi("PreCondit",      { fg = c.fl_orange })

hi("Type",           { fg = c.fl_cyan })
hi("StorageClass",   { fg = c.fl_cyan })
hi("Structure",      { fg = c.fl_cyan })
hi("Typedef",        { fg = c.fl_cyan })

hi("Special",        { fg = c.fl_orange })
hi("SpecialChar",    { fg = c.fl_orange })
hi("Tag",            { fg = c.fl_red })
hi("Delimiter",      { fg = c.gray })
hi("SpecialComment", { fg = c.gray, italic = true, bold = true })
hi("Debug",          { fg = c.fl_red })

hi("Underlined",     { fg = c.fl_cyan, underline = true })
hi("Ignore",         { fg = c.dark_gray })
hi("Error",          { fg = c.fl_red, bg = c.maroon, bold = true })
hi("Todo",           { fg = c.fl_yellow, bg = c.olive, bold = true })

-- ============================================================================
-- Treesitter highlights (linked to base groups + overrides)
-- ============================================================================
hi("@variable",              { fg = c.green })
hi("@variable.builtin",      { fg = c.fl_cyan, italic = true })
hi("@variable.parameter",    { fg = c.fl_orange })
hi("@variable.member",       { fg = c.light_green })

hi("@constant",              { link = "Constant" })
hi("@constant.builtin",      { fg = c.fl_magenta })
hi("@constant.macro",        { fg = c.fl_orange })

hi("@module",                { fg = c.fl_cyan })
hi("@label",                 { link = "Label" })

hi("@string",                { link = "String" })
hi("@string.escape",         { fg = c.fl_orange })
hi("@string.regex",          { fg = c.fl_orange })
hi("@string.special",        { fg = c.fl_orange })

hi("@character",             { link = "Character" })
hi("@number",                { link = "Number" })
hi("@boolean",               { link = "Boolean" })
hi("@float",                 { link = "Float" })

hi("@function",              { fg = c.light_green })
hi("@function.builtin",      { fg = c.fl_green })
hi("@function.call",         { fg = c.light_green })
hi("@function.macro",        { fg = c.fl_orange })
hi("@function.method",       { fg = c.light_green })
hi("@function.method.call",  { fg = c.light_green })

hi("@constructor",           { fg = c.fl_cyan })
hi("@operator",              { link = "Operator" })

hi("@keyword",               { fg = c.fl_red, italic = true })
hi("@keyword.coroutine",     { fg = c.fl_red, italic = true })
hi("@keyword.function",      { fg = c.fl_red, italic = true })
hi("@keyword.operator",      { fg = c.fl_red })
hi("@keyword.import",        { fg = c.fl_orange })
hi("@keyword.storage",       { fg = c.fl_cyan })
hi("@keyword.repeat",        { fg = c.fl_red })
hi("@keyword.return",        { fg = c.fl_red, italic = true })
hi("@keyword.exception",     { fg = c.fl_red })
hi("@keyword.conditional",   { fg = c.fl_red })

hi("@type",                  { fg = c.fl_cyan })
hi("@type.builtin",          { fg = c.fl_cyan, italic = true })
hi("@type.definition",       { fg = c.fl_cyan })
hi("@type.qualifier",        { fg = c.fl_red, italic = true })

hi("@attribute",             { fg = c.fl_orange })
hi("@property",              { fg = c.light_green })

hi("@punctuation.delimiter", { fg = c.gray })
hi("@punctuation.bracket",   { fg = c.gray })
hi("@punctuation.special",   { fg = c.fl_orange })

hi("@comment",               { link = "Comment" })
hi("@comment.documentation", { fg = c.gray, italic = true })

hi("@tag",                   { fg = c.fl_red })
hi("@tag.attribute",         { fg = c.fl_orange })
hi("@tag.delimiter",         { fg = c.gray })

hi("@markup.heading",        { fg = c.fl_cyan, bold = true })
hi("@markup.raw",            { fg = c.fl_yellow })
hi("@markup.link",           { fg = c.fl_cyan, underline = true })
hi("@markup.link.url",       { fg = c.fl_cyan, underline = true })
hi("@markup.list",           { fg = c.fl_red })
hi("@markup.strong",         { bold = true })
hi("@markup.italic",         { italic = true })
hi("@markup.strikethrough",  { strikethrough = true })

-- ============================================================================
-- LSP semantic tokens
-- ============================================================================
hi("@lsp.type.namespace",    { fg = c.fl_cyan })
hi("@lsp.type.type",         { fg = c.fl_cyan })
hi("@lsp.type.class",        { fg = c.fl_cyan })
hi("@lsp.type.enum",         { fg = c.fl_cyan })
hi("@lsp.type.interface",    { fg = c.fl_cyan })
hi("@lsp.type.struct",       { fg = c.fl_cyan })
hi("@lsp.type.parameter",    { fg = c.fl_orange })
hi("@lsp.type.variable",     { fg = c.green })
hi("@lsp.type.property",     { fg = c.light_green })
hi("@lsp.type.function",     { fg = c.light_green })
hi("@lsp.type.method",       { fg = c.light_green })
hi("@lsp.type.macro",        { fg = c.fl_orange })
hi("@lsp.type.decorator",    { fg = c.fl_orange })

-- ============================================================================
-- Plugin support
-- ============================================================================

-- Telescope
hi("TelescopeNormal",        { fg = c.green, bg = c.black })
hi("TelescopeBorder",        { fg = c.green, bg = c.black })
hi("TelescopePromptNormal",  { fg = c.white, bg = "#0A0A0A" })
hi("TelescopePromptBorder",  { fg = c.green, bg = "#0A0A0A" })
hi("TelescopePromptTitle",   { fg = c.black, bg = c.green, bold = true })
hi("TelescopePreviewTitle",  { fg = c.black, bg = c.fl_cyan, bold = true })
hi("TelescopeResultsTitle",  { fg = c.black, bg = c.fl_orange, bold = true })
hi("TelescopeSelection",     { fg = c.fl_blue, bg = c.white })
hi("TelescopeMatching",      { fg = c.fl_yellow, bold = true })

-- GitSigns
hi("GitSignsAdd",            { fg = c.fl_green })
hi("GitSignsChange",         { fg = c.fl_yellow })
hi("GitSignsDelete",         { fg = c.fl_red })

-- NvimTree / Neo-tree
hi("NvimTreeNormal",         { fg = c.green, bg = c.black })
hi("NvimTreeFolderIcon",     { fg = c.fl_cyan })
hi("NvimTreeFolderName",     { fg = c.fl_cyan })
hi("NvimTreeOpenedFolderName", { fg = c.fl_cyan, bold = true })
hi("NvimTreeGitDirty",       { fg = c.fl_yellow })
hi("NvimTreeGitNew",         { fg = c.fl_green })

-- Indent Blankline
hi("IndentBlanklineChar",    { fg = "#1A1A1A" })
hi("IblIndent",              { fg = "#1A1A1A" })
hi("IblScope",               { fg = c.mid_gray })

-- ============================================================================
-- Terminal colors
-- ============================================================================
vim.g.terminal_color_0  = c.black
vim.g.terminal_color_1  = c.fl_red
vim.g.terminal_color_2  = c.green
vim.g.terminal_color_3  = c.yellow
vim.g.terminal_color_4  = c.fl_blue
vim.g.terminal_color_5  = c.fl_magenta
vim.g.terminal_color_6  = c.fl_cyan
vim.g.terminal_color_7  = c.gray
vim.g.terminal_color_8  = c.mid_gray
vim.g.terminal_color_9  = c.fl_red
vim.g.terminal_color_10 = c.fl_green
vim.g.terminal_color_11 = c.fl_yellow
vim.g.terminal_color_12 = c.fl_blue
vim.g.terminal_color_13 = c.fl_magenta
vim.g.terminal_color_14 = c.fl_cyan
vim.g.terminal_color_15 = c.white
