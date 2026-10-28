-- ╭─────────────────────────────────────────╮
-- │             KEYMAPS.LUA                 │
-- ╰─────────────────────────────────────────╯

vim.g.mapleader = " "

local map = vim.keymap.set
local opts = function(desc) return { noremap = true, silent = true, desc = desc } end
-- keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } }, -- Keybinding to toggle Zen Mode

-- ── ZenMode ─────────────────────────────
map("n", "<leader>z", ":ZenMode<CR>", opts("Zen Mode"))
--
-- ── Neo-tree ─────────────────────────────
map("n", "<leader>e", ":Neotree toggle<CR>", opts("Explorer toggle"))
map("n", "<leader>o", ":Neotree focus<CR>", opts("Explorer focus"))
-- ── Telescope ────────────────────────────
map("n", "<leader>ff", ":Telescope find_files<CR>", opts("Find files"))
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts("Grep en proyecto"))
map("n", "<leader>fb", ":Telescope buffers<CR>", opts("Listar buffers"))
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts("Help tags"))
map("n", "<leader>fw", ":Telescope grep_string<CR>", opts("Grep palabra actual"))
-- Buscador de keymaps: filtra por atajo, modo o descripción.
-- Incluye los keymaps buffer-local (LSP) del buffer actual.
map("n", "<leader>fk", ":Telescope keymaps<CR>", opts("Buscar keymaps"))
map("n", "<leader>cs", ":Telescope colorscheme enable_preview=true<CR>", opts("Colorescheme (vista previa)"))

-- ── Bufferline: ir a buffer por número ───
map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts("Buffer 1"))
map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts("Buffer 2"))
map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts("Buffer 3"))
map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts("Buffer 4"))
map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts("Buffer 5"))

-- ── Bufferline: navegar circular H / L ───
map("n", "H", function()
  local current = vim.fn.bufnr("%")
  local buffers = vim.fn.getbufinfo({ bufloaded = 1, buflisted = 1 })
  for i, buf in ipairs(buffers) do
    if buf.bufnr == current then
      local target = buffers[i - 1] or buffers[#buffers]
      vim.cmd("buffer " .. target.bufnr)
      return
    end
  end
end, opts("Buffer anterior"))

map("n", "L", function()
  local current = vim.fn.bufnr("%")
  local buffers = vim.fn.getbufinfo({ bufloaded = 1, buflisted = 1 })
  for i, buf in ipairs(buffers) do
    if buf.bufnr == current then
      local target = buffers[i + 1] or buffers[1]
      vim.cmd("buffer " .. target.bufnr)
      return
    end
  end
end, opts("Buffer siguiente"))

-- ── Cerrar buffer sin cerrar ventana ─────
map("n", "<leader>x", ":bdelete<CR>", opts("Cerrar buffer"))

-- ── Ventanas ──────────────────────────────
map("n", "<leader>wh", "<C-w>h", opts("Ventana izquierda"))
map("n", "<leader>wj", "<C-w>j", opts("Ventana abajo"))
map("n", "<leader>wk", "<C-w>k", opts("Ventana arriba"))
map("n", "<leader>wl", "<C-w>l", opts("Ventana derecha"))
map("n", "<leader>ww", "<C-w>w", opts("Siguiente ventana"))
map("n", "<leader>ws", ":sp<CR>", opts("Horizontal Windo Split"))
map("n", "<leader>wv", ":vsp<CR>", opts("Vertical Window Split"))
map("n", "<leader>wq", ":q<CR>", opts("Close window"))
-- REDIMENSIONAR (sigue en <C-flechas>)
map("n", "<C-Up>", ":resize +2<CR>", opts("Aumentar alto"))
map("n", "<C-Down>", ":resize -2<CR>", opts("Disminuir alto"))
map("n", "<C-Left>", ":vertical resize -2<CR>", opts("Disminuir ancho"))
map("n", "<C-Right>", ":vertical resize +2<CR>", opts("Aumentar ancho"))
-- ── Diagnósticos (funcionan sin LSP) ──────
map("n", "<leader>k", vim.diagnostic.open_float, opts("Diagnóstico"))

-- Los keymaps de LSP (hover, definición, rename, code action) se
-- registran por buffer en lua/plugins/lsp.lua (LspAttach), para que
-- no aparezcan errores en buffers sin servidor.
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>s", ":w<CR>")
-- si
map("n", "<leader>la", ":Lazy<CR>", opts("Abrir Lazy"))
-- UI ---------------------------------------
vim.keymap.set("n", "<leader>ur", ":set relativenumber!<CR>", {
  desc = "Toggle relative numbers",
})
--window
--
