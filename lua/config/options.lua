-- ╭─────────────────────────────────────────╮
-- │             OPTIONS.LUA                 │
-- ╰─────────────────────────────────────────╯
--
local opt          = vim.opt

-- Números de línea
opt.number         = true
opt.relativenumber = true

-- Signcolumn: 2 columnas fijas para que gitsigns y los diagnósticos no se tapen
opt.signcolumn     = "yes:2"

-- Clipboard compartido con el sistema
opt.clipboard      = "unnamedplus"

-- Tabs y espacios
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.expandtab      = true
opt.smartindent    = true

-- Búsqueda
opt.ignorecase     = true
opt.smartcase      = true
opt.hlsearch       = false
opt.incsearch      = true

-- UI
opt.termguicolors  = true
opt.cursorline     = true
opt.scrolloff      = 8
opt.wrap           = false
opt.splitbelow     = true
opt.splitright     = true

-- Archivos
opt.swapfile       = false
opt.backup         = false
opt.undofile       = true
-- guicursor configurado en lua/config/highlights.lua

-- Actualización de diagnósticos, gitsigns y CursorHold
opt.updatetime     = 250
