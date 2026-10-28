-- ╭─────────────────────────────────────────╮
-- │            PLUGINS/LSP.LUA              │
-- ╰─────────────────────────────────────────╯

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- mason.nvim se declara en lua/plugins/mason.lua
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua-language-server",
          "gopls",
          "typescript-language-server",
          "html-lsp",
          "css-lsp",
          "json-lsp",
          "emmet-ls",
          "clangd",
          "python-lsp-server",
          "yaml-language-server",
        },
        auto_update = false,
        run_on_start = true,
      })

      -- nvim-lspconfig inyecta los defaults (cmd, filetypes, etc.) en
      -- Neovim 0.11+. Las capabilities se aplican una sola vez a todos
      -- los servidores; solo se sobreescribe lo que hace falta.
      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config.lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      }

      vim.lsp.config.jsonls = {
        settings = {
          json = {
            format = { enable = true },
            schemas = {
              ["https://json.schemastore.org/package.json"] = { "package.json" },
              ["https://json.schemastore.org/tsconfig.json"] = { "tsconfig*.json" },
            },
          },
        },
      }

      vim.lsp.enable({
        "yamlls",
        "lua_ls",
        "gopls",
        "ts_ls",
        "html",
        "cssls",
        "emmet_ls",
        "jsonls",
        "clangd",
        "pylsp",
      })

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN]  = "󰀪 ",
            [vim.diagnostic.severity.HINT]  = "󰌶 ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
      })

      -- Keymaps de LSP por buffer: solo existen donde hay un servidor.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
          end

          map("n", "<leader>gd", vim.lsp.buf.definition, "Ir a definición")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        end,
      })

      -- Formato al guardar solo si hay un cliente que sepa formatear.
      local format_group = vim.api.nvim_create_augroup("UserLspFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_group,
        callback = function(args)
          if vim.bo[args.buf].buftype ~= "" then
            return
          end
          local clients = vim.lsp.get_clients({
            bufnr = args.buf,
            method = "textDocument/formatting",
          })
          if #clients == 0 then
            return
          end
          vim.lsp.buf.format({
            bufnr   = args.buf,
            async   = false,
            timeout_ms = 2000,
            filter  = function(client)
              return client:supports_method("textDocument/formatting", args.buf)
            end,
          })
        end,
      })

      -- Evita que lsp.log crezca sin límite (llegan a decenas de MB
      -- por el stderr de algunos servidores).
      local lsp_log = vim.lsp.log.get_filename()
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          local stat = vim.uv.fs_stat(lsp_log)
          if stat and stat.size > 5 * 1024 * 1024 then
            pcall(vim.uv.fs_unlink, lsp_log)
          end
        end,
      })
    end,
  },
}
