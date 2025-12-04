vim.opt.clipboard = "unnamedplus" --always use system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" } --show complete options
vim.opt.mouse = "a"

-- Tab
vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { tab = "⌁ ", trail = "·", nbsp = "␣" }

-- UI conf
vim.opt.wrap = true
vim.opt.linebrek = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- Apply tab/indent settings globally, but also enforce for all filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.listchars = { tab = "⌁ ", trail = "·", nbsp = "␣" }
    vim.opt_local.list = true
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.list = true
    vim.opt.listchars = { tab = "⌁ ", trail = "·", nbsp = "␣" }
  end,
})
