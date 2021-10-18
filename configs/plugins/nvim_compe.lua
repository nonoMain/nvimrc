--startOfFile
-- Filename: nvim_compe.lua

vim.o.completeopt = "menuone,noselect,noinsert"
compe = require('compe')

compe.setup
{
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 10;
	max_kind_width = 10;
	max_menu_width = 10;
	documentation = true;

	source = {
		path = true;
		buffer = true;
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		spell = true;
		tags = true;
		ultisnips = true;
		treesitter = true;
	};
}

-- toggle function
local M = {}
M._locals = {}

M.toggle = function()
	local bufnr = vim.api.nvim_get_current_buf()
	if M._locals[bufnr] then
		compe.setup(M._locals[bufnr], bufnr)
		M._locals[bufnr] = nil
	else
		M._locals[bufnr] = vim.deepcopy(require('compe.config').get())
		compe.setup({enabled = false}, bufnr)
	end
end

M.setup = function(config, bufnr)
	if bufnr then
		if bufnr == 0 then
			bufnr = vim.api.nvim_get_current_buf()
		end
		if M._locals[bufnr] then
			M._locals[bufnr] = config
			return
		end
	end
	compe.setup(config, bufnr)
end


-- add CompeToggle function to vim cmd
vim.cmd([[
function! CompeSetup(config, ...) abort
	call luaeval('require"nvim-compe".setup(_A[1], _A[2])', [a:config, get(a:, 1, v:null)])
endfunction
]])
vim.cmd([[command! CompeToggle lua require'nvim-compe'.toggle()]])

return M
--endOfFile
