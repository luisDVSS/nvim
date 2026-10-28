-- ╭─────────────────────────────────────────╮
-- │          PLUGINS/COLORPICKER.LUA        │
-- │  Mezclador de color (chroma) sobre el   │
-- │  color bajo el cursor                    │
-- ╰─────────────────────────────────────────╯

return {
  {
    "inteist/chroma.nvim",
    -- lazy-load: solo se carga al usar el keymap o el comando
    cmd = { "ColorPicker", "ColorPickerCursor" },
    keys = {
      { "<leader>cp", "<cmd>ColorPickerCursor<cr>", desc = "Mezclador: color bajo cursor" },
      { "<leader>ci", "<cmd>ColorPicker<cr>", desc = "Insertar color desde mezclador" },
    },
    opts = {
      default_format = "hex",
      insert_on_confirm = true,
      live_preview = true,
    },
  },
}