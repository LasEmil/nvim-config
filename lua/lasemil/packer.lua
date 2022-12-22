vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
	  'projekt0n/github-nvim-theme',
	  config = function()
		  require('github-theme').setup({
			  theme_style = "dark_default"
		  })
	  end
  })
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use("mbbill/undotree");
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
}

use('neovim/nvim-lspconfig')
use({'jose-elias-alvarez/null-ls.nvim',
config = function ()

    local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
    local event = "BufWritePre" -- or "BufWritePost"
    local async = event == "BufWritePost"
    require("null-ls").setup({

        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.keymap.set("n", "<Leader>f", function()
                    vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                end, { buffer = bufnr, desc = "[lsp] format" })

                -- format on save
                vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                vim.api.nvim_create_autocmd(event, {
                    buffer = bufnr,
                    group = group,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr, async = async })
                    end,
                    desc = "[lsp] format on save",
                })
            end

            if client.supports_method("textDocument/rangeFormatting") then
                vim.keymap.set("x", "<Leader>f", function()
                    vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                end, { buffer = bufnr, desc = "[lsp] format" })
            end
        end,
    })
end})


use({'MunifTanjim/prettier.nvim',
config = function ()
   require("prettier").setup({
       bin = 'prettierd',
       filetypes = {
           "css",
           "graphql",
           "html",
           "javascript",
           "javascriptreact",
           "json",
           "less",
           "markdown",
           "scss",
           "typescript",
           "typescriptreact",
           "yaml",
       },
   })
end})
use({'windwp/nvim-ts-autotag',
    config = function ()
        require('nvim-ts-autotag').setup()
    end
})
use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}

use {
    "norcalli/nvim-colorizer.lua",
    config = function ()
        require("colorizer").setup()
    end
}
end)
