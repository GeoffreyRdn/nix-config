require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

require'lspconfig'.clangd.setup{
    cmd = { "/nix/store/cg074jhnyqqpd6zkk2l5rxn0y3mjr63i-system-path/bin/clangd" }
}

-- Basic settings
vim.opt.omnifunc = "syntaxcomplete"
vim.cmd("filetype plugin indent on")

-- Sensible defaults
vim.cmd("runtime! plugin/sensible.vim")

-- Encoding and syntax
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = ""
vim.cmd("syntax on")
vim.cmd("syntax enable")

-- Indentation
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Appearance
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 10
vim.opt.wildmenu = true

-- File behavior
vim.opt.autoread = true
vim.opt.autowrite = true

-- Special character display
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", eol = "$" }

-- Filetype-specific settings
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<F9>", ":w<CR>:exec '!python3' shellescape(@%, 1)<CR>", { noremap = true, silent = true })
    end
})

