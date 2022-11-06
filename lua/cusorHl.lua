-- Cusorline Highlighter
-- colorize your cusorline
-- @auther ds1sqe@mensakorea.org

local M = {}

M.toggleWindowHighlight = vim.api.nvim_create_augroup("toggleWindowHighlight", { clear = true })
M.cusorHighlight = vim.api.nvim_create_augroup("cusorHighlight", { clear = true })
--  Example of use
-- require('cusorHl').setup({
--  normal = "guibg = #355666", -- cusorline color of normal mode
-- 	insert = "guibg=#2e5c3f", -- "" of insert mode
-- 	visual = "guibg=#ad51a7", -- selected line's color of visual mode
-- 	nohighlightIfBufferLeave = true, -- if you leave current buffer, remove highlight
-- })
function M.setup(setting)
	local autoCmd = vim.api.nvim_create_autocmd

	-- default settings are, normal = skyblue, insert = green , visual = pink , turn off if leave buffer = true
	local config = {
		normal = "guibg=#355666",
		insert = "guibg=#2e5c3f",
		visual = "guibg=#ad51a7",
		nohighlightIfBufferLeave = true,
	}

	vim.tbl_extend("force", config, setting)

	autoCmd("InsertLeave", {
		group = M.cusorHighlight,
		pattern = { "*" },
		command = "hi CursorLine " .. config.normal,
	})
	autoCmd("InsertEnter", {
		group = M.cusorHighlight,
		pattern = { "*" },
		command = "hi CursorLine " .. config.insert,
	})
	autoCmd("InsertLeave", {
		group = M.cusorHighlight,
		pattern = { "*" },
		command = "hi Visual " .. config.visual,
	})

	if config.nohighlightIfBufferLeave then
		autoCmd("BufEnter", {
			group = M.toggleWindowHighlight,
			pattern = "*",
			command = "set relativenumber cursorline",
		})

		autoCmd("BufLeave", {
			group = M.toggleWindowHighlight,
			pattern = "*",
			command = "set norelativenumber nocursorline",
		})
	end
end

return M
