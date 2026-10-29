-- ╭─────────────────────────────────────────╮
-- │             PLUGINS/UI.LUA              │
-- ╰─────────────────────────────────────────╯

return {

  {
    "luisDVSS/as-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("as").setup({})
      vim.cmd.colorscheme("as-him")
    end,
  },
  -- ── Colorscheme: Gruvbox (activo) ─────
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        contrast = "hard",
        transparent_mode = false,
      })
    end,
  },

  -- Temas de backup (se cargan al arranque pero NO se aplican:
  -- el activo sigue siendo gruvbox). Aplicate con <leader>cs
  -- para previsualizarlos con el cursor.
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require("kanagawa").setup({ transparent = false })
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    config = function()
      require("onedarkpro").setup({
        styles = { comments = "italic", keywords = "bold" },
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          treesitter = true,
          telescope = { enabled = true },
          bufferline = true,
          lualine = true,
          alpha = true,
          neo_tree = true,
          render_markdown = true,
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ transparent = false })
    end,
  },

  -- ── Dashboard (Alpha) ──────────────────
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local alpha                   = require("alpha")
      local dashboard               = require("alpha.themes.dashboard")

      dashboard.section.header.val  = {
        "██████╗ ███████╗██╗   ██╗███████╗ ██████╗ ███╗   ██╗███████╗",
        "██╔══██╗██╔════╝██║   ██║╚══███╔╝██╔═══██╗████╗  ██║██╔════╝",
        "██║  ██║█████╗  ██║   ██║  ███╔╝ ██║   ██║██╔██╗ ██║█████╗  ",
        "██║  ██║██╔══╝  ╚██╗ ██╔╝ ███╔╝  ██║   ██║██║╚██╗██║██╔══╝  ",
        "██████╔╝███████╗ ╚████╔╝ ███████╗╚██████╔╝██║ ╚████║███████╗",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "  Nuevo archivo", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Buscar archivo", ":Telescope find_files<CR>"),
        dashboard.button("g", "  Buscar texto", ":Telescope live_grep<CR>"),
        dashboard.button("r", "  Recientes", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "  Salir", ":qa<CR>"),
      }

      alpha.setup(dashboard.opts)
    end,
  },

  -- ── Lualine (statusbar) ────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled        = true,
          theme                = "auto",
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
          globalstatus         = true, -- una sola barra para todas las ventanas
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            -- Opciones del componente van DENTRO de su propia tabla.
            -- path = 1 → ruta relativa al cwd (no solo el nombre).
            -- shorting_target recorta por la izquierda si es muy larga.
            {
              "filename",
              path            = 1,
              shorting_target = 40,
              symbols         = {
                modified = " ●",
                readonly = " ",
                unnamed  = "[Sin nombre]",
              },
            },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_c = { { "filename", path = 1, shorting_target = 40 } },
          lualine_x = { "location" },
        },
      })
    end,
  },

  -- ── Bufferline (tabs de archivos) ──────
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("bufferline").setup({
        options = {
          always_show_bufferline = false, -- se oculta si solo hay 1 buffer
          numbers                = "none",
          close_command          = "bdelete %d",
          right_mouse_command    = "bdelete %d",
          left_trunc_marker      = "<",
          right_trunc_marker     = ">",
          max_name_length        = 30,
          tab_size               = 21,
          diagnostics            = "nvim_lsp",
          enforce_regular_tabs   = false,
          auto_scroll            = true,
          offsets                = {
            {
              filetype   = "neo-tree",
              text       = "File Explorer",
              text_align = "left",
              padding    = 1,
            },
          },
        },
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = "markdown",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- El parser de latex no está instalado; desactivarlo evita el warning.
      latex = { enabled = false },
    },
  },

  -- ── Which-key (ayuda de keymaps) ───────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- ── Gitsigns (git en la gutter) ────────
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "┃" },
          change       = { text = "┃" },
          delete       = { text = "" },
          topdelete    = { text = "" },
          changedelete = { text = "┃" },
        },
        current_line_blame = true,
        current_line_blame_opts = { delay = 500 },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode", -- Command to toggle Zen Mode
    opts = {
      plugins = {
        gitsigns = true,                         -- Enable gitsigns integration
        tmux = false,                            -- Enable tmux integration
        kitty = { enabled = true, font = "+2" }, -- Disable kitty integration and set font size
        twilight = { enabled = true },           -- Enable twilight integration
      },
    },
  }

}
