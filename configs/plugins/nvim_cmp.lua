--	File Documentation
-- Filename: nvim_cmp.lua
-- Author: nonomain
-- last updated: 31/01/22 17:43:27
-- Description:
--	configuration for the nvim_cmp plugin


local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

vim.o.completeopt = "menu,menuone,noselect"

vim.g.cmp_toggle_flag = false -- initialize
local normal_buftype = function()
  return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
end

local toggle_completion = function()
    local next_cmp_toggle_flag = not vim.g.cmp_toggle_flag
    if next_cmp_toggle_flag then
      print("completion on")
    else
      print("completion off")
    end
    cmp.setup({
      enabled = function()
        vim.g.cmp_toggle_flag = next_cmp_toggle_flag
        if next_cmp_toggle_flag then
          return normal_buftype
        else
          return next_cmp_toggle_flag
        end
      end,
    })
end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

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
		['<C-y>'] = cmp.mapping.confirm({ select = false }),
		-- previous item
		['<C-p>'] = function(fallback)
			if cmp.visible() then
			cmp.select_prev_item()
			else
			fallback()
			end
		end;
		-- next item
		['<C-n>'] = function(fallback)
			if cmp.visible() then
			cmp.select_next_item()
			else
			fallback()
			end
		end;
		-- toggle completion
		["<C-k>"] = cmp.mapping({
			i = function()
				if cmp.visible() then
					cmp.abort()
					toggle_completion()
				else
					cmp.complete()
					toggle_completion()
				end
			end,
		}),
	},

	-- Source options:
	-- keyword_length
	-- priority
	-- max_item_count
	sources = cmp.config.sources {
		{ name = 'nvim_lsp',   priority = 90, },
		{ name = 'path',       priority = 80, },
		{ name = 'ultisnips',  priority = 70, },
		{ name = 'treesitter', priority = 60, },
		{ name = 'buffer',     priority = 50, keyword_length = 3},
		{ name = 'spell',      priority = 40, },
	},

	formatting = {
		format = function(entry, vim_item)
			if vim.g.Use_nerdfont == 1 then
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			else
				vim_item.kind = string.format("%s",  vim_item.kind)
			end
			vim_item.menu = ({
				buffer = "[buf]",
				path = "[PATH]",
				spell = "[SPELL]",
				nvim_lsp = "[LSP]",
				ultisnips = "[snips]",
			}) [entry.source.name]
			return vim_item
			end,
	},
	window = {
		documentation = {
			border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
			winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
		},
		completion = {
			border = {'┌', '─', '┐', '│', '┘', '─', '└', '│'},
			winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
		}
	},
}

