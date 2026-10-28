-- return {
--
-- {
--   "folke/noice.nvim",
--   event = "VeryLazy",
--   dependencies = {
--     "MunifTanjim/nui.nvim",
--     "rcarriga/nvim-notify",
--   },
--   opts = {
--     lsp = {
--       -- mejor rendering de markdown en cmp y otros plugins
--       override = {
--         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--         ["vim.lsp.util.stylize_markdown"] = true,
--         ["cmp.entry.get_documentation"] = true, -- requiere nvim-cmp
--       },
--     },
--     presets = {
--       bottom_search = true,        -- búsqueda clásica abajo
--       command_palette = true,      -- cmdline y popupmenu juntos
--       long_message_to_split = true, -- mensajes largos en split
--     },
--   },
-- },
-- }
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      notify = {
        enabled = false,
      },

      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },

      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
}
