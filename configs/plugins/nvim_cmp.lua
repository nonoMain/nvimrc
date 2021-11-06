--startOfFile
-- Filename: nvim_cmp.lua

vim.o.completeopt = "menu,menuone,noselect"
local cmp = require'cmp'
local lspkind = require "lspkind"

cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
	end,
	},

	mapping = {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	},

	-- Source options:
	-- keyword_length
	-- priority
	-- max_item_count
	sources = cmp.config.sources {
		{ name = 'nvim_lsp',   priority = 90, max_item_count = 10},
		{ name = 'path',       priority = 80, max_item_count = 10},
		{ name = 'ultisnips',  priority = 70, max_item_count = 10},
		{ name = 'treesitter', priority = 60, max_item_count = 10},
		{ name = 'buffer',     priority = 50, max_item_count = 10, keyword_length = 3},
		{ name = 'spell',      priority = 40, max_item_count = 10},
	},

	formatting = {
		format = function(entry, vim_item)
			if vim.g.Use_nerdfont == 1 then
				vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
			else
				vim_item.kind = string.format("%s",  vim_item.kind)
			end
			vim_item.menu = ({
				buffer = "[buf]",
				path = "[PATH]",
				nvim_lsp = "[LSP]",
				ultisnips = "[snips]",
			}) [entry.source.name]
			return vim_item
			end,
	},

	experimental = {
		native_menu = false,
		ghost_text = false,
	},
}

--endOfFile
