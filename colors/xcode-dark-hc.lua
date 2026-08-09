vim.cmd.highlight("clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "xcode-dark-hc"

-- Xcode Dark High Contrast, adapted through Ghostty's Xcode Dark hc theme.
-- palette so the editor and terminal render as one coherent theme.
local c = {
  background = "#292a30",
  surface = "#2f3239",
  surface_high = "#3a3c43",
  selection = "#43454b",
  muted = "#696a6e",
  foreground = "#e0e0e1",

  attribute = "#e1a779",
  comment = "#7cb554",
  doc_keyword = "#acf07b",
  declaration = "#47b4d0",
  declaration_type = "#6bdfff",
  keyword = "#ff7bb1",
  macro = "#ffa14f",
  number = "#d9c668",
  project_symbol = "#78c2b3",
  project_type = "#acf2e4",
  string = "#ff8a7a",
  system_symbol = "#b182eb",
  system_type = "#dbbbfe",
  url = "#739aff",

  tree_icon = "#65777a",
  tree_arrow = "#59666b",
  tree_indent = "#484c53",

  error = "#f74a4a",
  warning = "#efb759",
  info = "#6bdfff",
  hint = "#b1faeb",
  breakpoint = "#4a4af7",
  stopped = "#b4cc8b",
}

local function highlight(groups, style)
  if type(groups) == "string" then
    groups = { groups }
  end

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, style)
  end
end

local function link(groups, target)
  highlight(groups, { link = target })
end

-- Editor chrome.
highlight({ "Normal", "NormalNC" }, { fg = c.foreground, bg = c.background })
highlight("NormalFloat", { fg = c.foreground, bg = c.surface })
highlight("FloatBorder", { fg = c.selection, bg = c.surface })
highlight("FloatTitle", { fg = c.declaration_type, bg = c.surface, bold = true })
highlight("Cursor", { fg = c.background, bg = c.foreground })
link("lCursor", "Cursor")
link("TermCursor", "Cursor")
highlight({ "CursorLine", "CursorColumn" }, { bg = c.surface })
highlight("ColorColumn", { bg = c.surface })
highlight("LineNr", { fg = c.muted, bg = c.background })
highlight("CursorLineNr", { fg = c.foreground, bg = c.surface, bold = true })
highlight({ "SignColumn", "FoldColumn" }, { fg = c.muted, bg = c.background })
highlight("Folded", { fg = c.muted, bg = c.surface })
highlight("EndOfBuffer", { fg = c.background, bg = c.background })
highlight({ "NonText", "Whitespace", "SpecialKey" }, { fg = c.selection })
highlight("Visual", { fg = c.foreground, bg = c.selection })
link("VisualNOS", "Visual")
highlight("Search", { fg = c.background, bg = c.number })
highlight({ "IncSearch", "CurSearch" }, { fg = c.background, bg = c.macro, bold = true })
highlight("MatchParen", { fg = c.foreground, bg = c.selection, bold = true })
highlight("WinSeparator", { fg = c.selection, bg = c.background })
highlight("StatusLine", { fg = c.foreground, bg = c.surface })
highlight("StatusLineNC", { fg = c.muted, bg = c.surface })
highlight("TabLine", { fg = c.muted, bg = c.surface })
highlight("TabLineFill", { bg = c.background })
highlight("TabLineSel", { fg = c.foreground, bg = c.selection, bold = true })
highlight("Pmenu", { fg = c.foreground, bg = c.surface })
highlight("PmenuSel", { fg = c.foreground, bg = c.selection, bold = true })
highlight("PmenuMatch", { fg = c.declaration_type, bg = c.surface, bold = true })
highlight("PmenuMatchSel", { fg = c.declaration_type, bg = c.selection, bold = true })
highlight("PmenuSbar", { bg = c.surface_high })
highlight("PmenuThumb", { bg = c.muted })
highlight("QuickFixLine", { bg = c.surface_high, bold = true })
highlight("Directory", { fg = c.declaration_type })
highlight("Title", { fg = c.declaration_type, bold = true })
highlight("Question", { fg = c.project_type })
highlight("MoreMsg", { fg = c.project_symbol })
highlight("WarningMsg", { fg = c.warning })
highlight("ErrorMsg", { fg = c.error, bold = true })

-- Vim syntax groups and language-independent Tree-sitter captures.
highlight("Comment", { fg = c.comment })
highlight("Constant", { fg = c.project_symbol })
highlight("String", { fg = c.string })
highlight("Character", { fg = c.number })
highlight("Number", { fg = c.number })
link("Boolean", "Number")
link("Float", "Number")
highlight("Identifier", { fg = c.foreground })
highlight("Function", { fg = c.project_symbol })
highlight("Statement", { fg = c.keyword, bold = true })
link({ "Conditional", "Repeat", "Label", "Operator", "Keyword", "Exception" }, "Statement")
highlight("PreProc", { fg = c.macro })
link({ "Include", "Define", "Macro", "PreCondit" }, "PreProc")
highlight("Type", { fg = c.project_type })
link({ "StorageClass", "Structure", "Typedef" }, "Type")
highlight("Special", { fg = c.attribute })
highlight("Underlined", { fg = c.url, underline = true })
highlight("Todo", { fg = c.doc_keyword, bold = true })

highlight("@comment", { fg = c.comment })
highlight("@comment.documentation", { fg = c.comment })
highlight({ "@comment.todo", "@comment.note" }, { fg = c.doc_keyword, bold = true })
highlight("@string", { fg = c.string })
highlight("@string.escape", { fg = c.string })
highlight("@character", { fg = c.number })
highlight({ "@number", "@number.float", "@boolean" }, { fg = c.number })
highlight("@attribute", { fg = c.system_type })
highlight("@constant", { fg = c.project_symbol })
highlight("@constant.builtin", { fg = c.system_symbol })
highlight({ "@constant.macro", "@function.macro" }, { fg = c.macro })
highlight({ "@function", "@function.call", "@function.method", "@function.method.call" }, { fg = c.project_symbol })
highlight("@function.declaration", { fg = c.declaration })
highlight("@constructor", { fg = c.keyword, bold = true })
highlight({ "@type", "@type.builtin" }, { fg = c.project_type })
highlight("@type.declaration", { fg = c.declaration_type })
highlight("@variable", { fg = c.foreground })
highlight("@variable.builtin", { fg = c.system_symbol })
highlight("@variable.member", { fg = c.project_symbol })
highlight("@variable.parameter", { fg = c.foreground })
highlight("@keyword", { fg = c.keyword, bold = true })
highlight("@keyword.directive", { fg = c.macro })
highlight({ "@keyword.declaration", "@keyword.function", "@keyword.type" }, { fg = c.keyword, bold = true })
highlight({ "@operator", "@punctuation.bracket", "@punctuation.delimiter", "@punctuation.special" }, { fg = c.foreground })
highlight("@label", { fg = c.foreground })
highlight("@markup.link.url", { fg = c.url, underline = true })

-- Swift's Tree-sitter captures use the same categories Xcode exposes in its
-- Fonts & Colors settings. Generic locals remain plain until SourceKit can
-- classify them as a property, method, project type, or SDK symbol.
local swift = {
  ["@attribute.swift"] = { fg = c.system_type },
  ["@boolean.swift"] = { fg = c.number },
  ["@character.special.swift"] = { fg = c.number },
  ["@comment.swift"] = { fg = c.comment },
  ["@comment.documentation.swift"] = { fg = c.comment },
  ["@comment.todo.swift"] = { fg = c.doc_keyword, bold = true },
  ["@constant.builtin.swift"] = { fg = c.system_symbol },
  ["@constant.macro.swift"] = { fg = c.macro },
  ["@constructor.swift"] = { fg = c.keyword, bold = true },
  ["@function.call.swift"] = { fg = c.project_symbol },
  ["@function.declaration.swift"] = { fg = c.declaration },
  ["@function.macro.swift"] = { fg = c.macro },
  ["@function.method.swift"] = { fg = c.project_symbol },
  ["@keyword.declaration.swift"] = { fg = c.keyword, bold = true },
  ["@keyword.directive.swift"] = { fg = c.macro },
  ["@keyword.function.swift"] = { fg = c.keyword, bold = true },
  ["@keyword.type.swift"] = { fg = c.keyword, bold = true },
  ["@label.swift"] = { fg = c.foreground },
  ["@number.float.swift"] = { fg = c.number },
  ["@number.swift"] = { fg = c.number },
  ["@operator.swift"] = { fg = c.foreground },
  ["@punctuation.bracket.swift"] = { fg = c.foreground },
  ["@punctuation.delimiter.swift"] = { fg = c.foreground },
  ["@punctuation.special.swift"] = { fg = c.foreground },
  ["@string.escape.swift"] = { fg = c.string },
  ["@string.regexp.swift"] = { fg = c.string },
  ["@string.swift"] = { fg = c.string },
  ["@type.swift"] = { fg = c.project_type },
  ["@type.declaration.swift"] = { fg = c.declaration_type },
  ["@variable.builtin.swift"] = { fg = c.system_symbol },
  ["@variable.member.swift"] = { fg = c.project_symbol },
  ["@variable.parameter.swift"] = { fg = c.foreground },
  ["@variable.swift"] = { fg = c.foreground },
}

local swift_keywords = {
  "keyword",
  "keyword.conditional",
  "keyword.conditional.ternary",
  "keyword.coroutine",
  "keyword.exception",
  "keyword.import",
  "keyword.modifier",
  "keyword.operator",
  "keyword.repeat",
  "keyword.return",
}

for _, capture in ipairs(swift_keywords) do
  swift["@" .. capture .. ".swift"] = { fg = c.keyword, bold = true }
end

for group, style in pairs(swift) do
  highlight(group, style)
end

-- SourceKit semantic tokens supply Xcode's project/system distinction.
local project_types = { "namespace", "type", "class", "enum", "interface", "struct", "typeParameter", "concept" }
local project_symbols = { "property", "enumMember", "event", "function", "method" }
local plain_symbols = { "parameter", "variable", "identifier" }

for _, token in ipairs(project_types) do
  highlight({ "@lsp.type." .. token, "@lsp.type." .. token .. ".swift" }, { fg = c.project_type })
  highlight({
    "@lsp.typemod." .. token .. ".declaration",
    "@lsp.typemod." .. token .. ".declaration.swift",
    "@lsp.typemod." .. token .. ".definition",
    "@lsp.typemod." .. token .. ".definition.swift",
  }, { fg = c.declaration_type })
  highlight({
    "@lsp.typemod." .. token .. ".defaultLibrary",
    "@lsp.typemod." .. token .. ".defaultLibrary.swift",
  }, { fg = c.system_type })
end

for _, token in ipairs(project_symbols) do
  highlight({ "@lsp.type." .. token, "@lsp.type." .. token .. ".swift" }, { fg = c.project_symbol })
  if token == "function" or token == "method" then
    highlight({
      "@lsp.typemod." .. token .. ".declaration",
      "@lsp.typemod." .. token .. ".declaration.swift",
      "@lsp.typemod." .. token .. ".definition",
      "@lsp.typemod." .. token .. ".definition.swift",
    }, { fg = c.declaration })
  end
  highlight({
    "@lsp.typemod." .. token .. ".defaultLibrary",
    "@lsp.typemod." .. token .. ".defaultLibrary.swift",
  }, { fg = c.system_symbol })
end

for _, token in ipairs(plain_symbols) do
  highlight({ "@lsp.type." .. token, "@lsp.type." .. token .. ".swift" }, { fg = c.foreground })
  highlight({
    "@lsp.typemod." .. token .. ".defaultLibrary",
    "@lsp.typemod." .. token .. ".defaultLibrary.swift",
  }, { fg = c.system_symbol })
end

highlight({ "@lsp.type.macro", "@lsp.type.macro.swift" }, { fg = c.macro })
highlight({
  "@lsp.typemod.macro.defaultLibrary",
  "@lsp.typemod.macro.defaultLibrary.swift",
}, { fg = c.macro })
highlight({ "@lsp.type.keyword", "@lsp.type.keyword.swift" }, { fg = c.keyword, bold = true })
highlight({ "@lsp.type.comment", "@lsp.type.comment.swift" }, { fg = c.comment })
highlight({ "@lsp.type.string", "@lsp.type.string.swift" }, { fg = c.string })
highlight({ "@lsp.type.regexp", "@lsp.type.regexp.swift" }, { fg = c.string })
highlight({ "@lsp.type.number", "@lsp.type.number.swift" }, { fg = c.number })
highlight({ "@lsp.type.decorator", "@lsp.type.decorator.swift" }, { fg = c.attribute })
highlight({ "@lsp.type.operator", "@lsp.type.operator.swift" }, { fg = c.foreground })
highlight({ "@lsp.type.bracket", "@lsp.type.bracket.swift" }, { fg = c.foreground })
highlight({ "@lsp.mod.defaultLibrary", "@lsp.mod.defaultLibrary.swift" }, { fg = c.system_symbol })

-- Diagnostics, diffs, and debugger state use Xcode's marker colors.
highlight("DiagnosticError", { fg = c.error })
highlight("DiagnosticWarn", { fg = c.warning })
highlight("DiagnosticInfo", { fg = c.info })
highlight("DiagnosticHint", { fg = c.hint })
highlight("DiagnosticOk", { fg = c.project_symbol })
highlight("DiagnosticUnderlineError", { undercurl = true, sp = c.error })
highlight("DiagnosticUnderlineWarn", { undercurl = true, sp = c.warning })
highlight("DiagnosticUnderlineInfo", { undercurl = true, sp = c.info })
highlight("DiagnosticUnderlineHint", { undercurl = true, sp = c.hint })
highlight({ "LspReferenceText", "LspReferenceRead" }, { bg = c.surface_high })
highlight("LspReferenceWrite", { bg = c.selection, bold = true })
highlight("LspSignatureActiveParameter", { fg = c.declaration_type, bold = true })
highlight("DiffAdd", { fg = c.project_type, bg = "#29443f" })
highlight("DiffChange", { fg = c.declaration_type, bg = "#283d45" })
highlight("DiffDelete", { fg = c.string, bg = "#4a2d2d" })
highlight("DiffText", { fg = c.foreground, bg = "#365666", bold = true })
highlight({ "GitSignsAdd", "NvimTreeGitNew" }, { fg = c.project_type })
highlight({ "GitSignsChange", "NvimTreeGitDirty" }, { fg = c.declaration_type })
highlight({ "GitSignsDelete", "NvimTreeGitDeleted" }, { fg = c.string })
highlight("DapBreakpoint", { fg = c.breakpoint })
highlight("DapBreakpointCondition", { fg = c.warning })
highlight("DapLogPoint", { fg = c.info })
highlight({ "DapStopped", "DapStoppedLine" }, { fg = c.stopped, bg = c.surface })

-- Common plugin surfaces.
highlight({ "TelescopeNormal", "TelescopePromptNormal", "TelescopeResultsNormal", "TelescopePreviewNormal" }, {
  fg = c.foreground,
  bg = c.background,
})
highlight({ "TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder" }, {
  fg = c.selection,
  bg = c.background,
})
highlight("TelescopeSelection", { bg = c.surface_high, bold = true })
highlight("TelescopeMatching", { fg = c.declaration_type, bold = true })
highlight("TelescopePromptPrefix", { fg = c.keyword })
highlight({ "NvimTreeNormal", "NvimTreeNormalNC" }, { fg = c.foreground, bg = c.background })
highlight("NvimTreeWinSeparator", { fg = c.selection, bg = c.background })
highlight("NvimTreeRootFolder", { fg = c.project_type, bold = true })
highlight("NvimTreeFolderName", { fg = c.project_symbol })
highlight("NvimTreeEmptyFolderName", { fg = c.project_symbol })
highlight("NvimTreeSymlinkFolderName", { fg = c.project_symbol })
highlight("NvimTreeOpenedFolderName", { fg = c.project_symbol, bold = true })
highlight({ "NvimTreeFolderIcon", "NvimTreeOpenedFolderIcon", "NvimTreeClosedFolderIcon" }, { fg = c.tree_icon })
highlight({ "NvimTreeFolderArrowClosed", "NvimTreeFolderArrowOpen" }, { fg = c.tree_arrow })
highlight("NvimTreeIndentMarker", { fg = c.tree_indent })
highlight({ "NvimTreeExecFile", "NvimTreeImageFile", "NvimTreeSpecialFile", "NvimTreeSymlink" }, {
  fg = c.foreground,
})
highlight("NvimTreeOpenedHL", { fg = "#ffffff", bold = true })
highlight("CmpItemAbbr", { fg = c.foreground })
highlight("CmpItemAbbrDeprecated", { fg = c.muted, strikethrough = true })
highlight("CmpItemAbbrMatch", { fg = c.declaration_type, bold = true })
highlight("CmpItemKind", { fg = c.system_type })
highlight("WhichKey", { fg = c.declaration_type })
highlight("WhichKeyDesc", { fg = c.foreground })
highlight("WhichKeyGroup", { fg = c.system_type, bold = true })
highlight("WhichKeySeparator", { fg = c.muted })
highlight("WhichKeyValue", { fg = c.project_symbol })

-- Keep :terminal buffers aligned with Ghostty's bundled Xcode Dark hc theme.
local terminal = {
  "#43454b",
  "#ff8a7a",
  "#83c9bc",
  "#d9c668",
  "#4ec4e6",
  "#ff85b8",
  "#cda1ff",
  "#ffffff",
  "#838991",
  "#ff8a7a",
  "#b1faeb",
  "#ffa14f",
  "#6bdfff",
  "#ff85b8",
  "#e5cfff",
  "#ffffff",
}

for index, color in ipairs(terminal) do
  vim.g["terminal_color_" .. (index - 1)] = color
end
