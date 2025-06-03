local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
-- colorschemes
	{
		"catppuccin/nvim", name = "catppuccin", priority = 1000
	},
	"tanvirtin/monokai.nvim",
	"rebelot/kanagawa.nvim", 
	{
		'akinsho/bufferline.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
    },

-- Navigation
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim'}
	},
	{
        "phaazon/hop.nvim",
        lazy = true,
    },
	{
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
	"nvim-tree/nvim-tree.lua",
	{ "nvim-tree/nvim-web-devicons", opts = {} },

-- LSP manager
	"williamboman/mason.nvim",
	 "williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

-- 42 Header
	{
	"Diogo-ss/42-header.nvim",
	cmd = { "Stdheader" },
	keys = { "<F1>" },
	opts = {
		default_map = true, -- Default mapping <F1> in normal mode.
		auto_update = true, -- Update header when saving.
		user = "uschmidt", -- Your user.
		mail = "uschmidt@student.42berlin.de", -- Your mail.
	},
	config = function(_, opts)
		require("42header").setup(opts)
	end,
	},

-- Norminette
    {
      "hardyrafael17/norminette42.nvim",
      config = function()
      local norminette = require("norminette")
      norminette.setup({
          runOnSave = true,
          maxErrorsToShow = 5,
          active = false,
      })
    end,
    }
})
