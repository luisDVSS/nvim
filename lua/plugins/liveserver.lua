-- ╭─────────────────────────────────────────╮
-- │           PLUGINS/LIVESERVER.LUA        │
-- │  Live Server: recarga en vivo al guardar │
-- ╰─────────────────────────────────────────╯

return {
  {
    "selimacerbas/live-server.nvim",
    dependencies = {
      "folke/which-key.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      default_port = 8000,
      open_on_start = true,
      live_reload = {
        enabled = true,
        inject_script = true,
        debounce = 120,
        css_inject = true,
      },
      directory_listing = {
        enabled = true,
        show_hidden = false,
      },
    },
    keys = {
      { "<leader>ls", "<cmd>LiveServerStart<cr>", desc = "Start (path y puerto)" },
      { "<leader>lo", "<cmd>LiveServerOpen<cr>", desc = "Abrir en navegador" },
      { "<leader>lr", "<cmd>LiveServerReload<cr>", desc = "Recargar forzado" },
      { "<leader>lS", "<cmd>LiveServerStop<cr>", desc = "Detener" },
      { "<leader>lA", "<cmd>LiveServerStopAll<cr>", desc = "Detener todos" },
      { "<leader>li", "<cmd>LiveServerStatus<cr>", desc = "Estado de servidores" },
    },
    config = function(_, opts)
      require("live_server").setup(opts)
    end,
  },
}