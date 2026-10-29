-- ╭─────────────────────────────────────────╮
-- │            PLUGINS/COLORS.LUA           │
-- │  Vista previa de colores en el buffer   │
-- ╰─────────────────────────────────────────╯
return {
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        -- Limitar los filetypes evita escanear todos los buffers (coste
        -- en archivos grandes). Se añaden los que sueles usar.
        filetypes = {
          "css",
          "html",
          "javascript",
          "typescript",
          "typescriptreact",
          "lua",
          "json",
          "yaml",
          "markdown",
          css = { names = true, css = true },
          html = { names = true, css = true },
        },
        user_default_options = {
          mode = "background",
        },
      })
    end,
  },
}

