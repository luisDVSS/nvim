-- Bootstrap lazy.nvim (lo descarga si no existe)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
vim.g.neovide_cursor_animation_length = 0
-- vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_position_animation_length = 0
if not uv.fs_stat(lazypath) then
  vim.fn.system({

    "git", "clone", "--filter=blob:none",

    "https://github.com/folke/lazy.nvim.git",

    "--branch=stable",

    lazypath,

  })
end

vim.opt.rtp:prepend(lazypath)

-- Cargar opciones y keymaps ANTES de los plugins

require("config.options")

require("config.keymaps")

require("config.highlights")

-- Cargar plugins

require("lazy").setup("plugins")

-- Colorscheme (al final para que highlights lo sobreescriban correctamente)

-- vim.cmd("colorscheme onedark")
