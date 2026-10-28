-- ╭─────────────────────────────────────────╮
-- │          PLUGINS/EXPLORE.LUA            │
-- ╰─────────────────────────────────────────╯

return {

  -- ── Treesitter (syntax highlighting) ───
  -- En la rama `main` de nvim-treesitter las opciones ensure_installed,
  -- highlight e indent de `opts` se ignoran: los parsers se instalan
  -- con require("nvim-treesitter").install().
{
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").install({
      "go",
      "lua",
      "vim",
      "vimdoc",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "python",
      "markdown",
      "markdown_inline",
    })

    -- Neovim 0.12 activa solo los parsers incluidos en runtime (lua, c,
    -- vim...). Los instalados en site/ (go, js, ts...) hay que arrancarlos.
    local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
},

  -- ── Telescope (buscador) ───────────────
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope", -- carga solo cuando usas :Telescope
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  -- ── Neo-tree (explorador de archivos) ──
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy=false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("neo-tree").setup({
        filesystem = {
      hijack_netrw_behavior = "open_current", -- abre Neo-tree en lugar de netrw
        },
        window = {
          mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
          },
        },
      })
    end,
  },

  -- ── Toggleterm (terminal integrada) ────
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { "<C-t>" }, -- carga solo cuando usas el shortcut
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-t>]],
        direction    = "float",
        float_opts   = { border = "curved" },
      })
    end,
  },
}
