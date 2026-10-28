-- ╭─────────────────────────────────────────╮
-- │           HIGHLIGHTS.LUA                │
-- ╰─────────────────────────────────────────╯
-- Se aplican cada vez que cambia el colorscheme
-- para que no sean sobreescritos por el tema
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Fondo transparente en la columna de números y signos
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "none" })

    -- ── Cursor ────────────────────────────────
    -- Se usan los colores de Normal invertidos para que el cursor
    -- tenga contraste tanto en temas claros como oscuros.
    local normal    = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local cursor_fg = normal.bg or "#1d2021"
    local cursor_bg = normal.fg or "#ebdbb2"
    vim.api.nvim_set_hl(0, "Cursor", { fg = cursor_fg, bg = cursor_bg })
    vim.api.nvim_set_hl(0, "CursorIM", { fg = cursor_fg, bg = "#b8bb26" })

    -- Bufferline re-aplica sus highlights después de este autocmd y
    -- rellena los grupos vacíos. Se difiere para que el fondo
    -- transparente gane. (Los nombres de highlight no distinguen
    -- mayúsculas; se usan los canónicos de bufferline.)
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "none" })
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
    end)
  end,
})

-- Forma del cursor (esto no lo afecta el tema, va fuera del autocmd)
vim.opt.guicursor = {
  "n-v-c:block-Cursor",
  "i-ci-ve:ver25-CursorIM",
  "r-cr:hor20",
}
