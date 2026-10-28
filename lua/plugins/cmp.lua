return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- fuente: LSP
      "hrsh7th/cmp-buffer",       -- fuente: palabras del buffer actual
      "hrsh7th/cmp-path",         -- fuente: rutas de archivos
      "L3MON4D3/LuaSnip",         -- motor de snippets
      "saadparwaiz1/cmp_luasnip", -- conecta LuaSnip con cmp
      "windwp/nvim-autopairs",    -- cierra pares al aceptar sugerencias
    },
    event = "InsertEnter",
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),                 -- forzar menú
          ["<CR>"]      = cmp.mapping.confirm({ select = true }), -- confirmar
          ["<Tab>"]     = cmp.mapping(function(fallback)          -- navegar abajo
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback) -- navegar arriba
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-e>"]     = cmp.mapping.abort(), -- cerrar menú
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- sugerencias del LSP (tu fmt., etc.)
          { name = "luasnip" },  -- snippets
          { name = "buffer" },   -- palabras del archivo actual
          { name = "path" },     -- rutas
        }),
      })

      -- Al confirmar con cmp, autopairs añade el paréntesis/corchete
      -- que falte (evita tener que cerrarlo a mano).
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
