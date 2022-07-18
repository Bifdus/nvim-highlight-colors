local M = {}

function M.get_buffer_contents()
	return vim.api.nvim_buf_get_lines(0, 0, -1, false)
end

function M.get_positions_by_regex(pattern)
	local positions = {}
	local content = M.get_buffer_contents()

	for key, value in pairs(content) do
		for match in string.gmatch(value, pattern) do
			local startColumn = vim.fn.match(value, match)
			local endColumn = vim.fn.matchend(value, match)
			table.insert(positions, {
				row = key,
				startColumn = startColumn,
				endColumn = endColumn
			})
		end
	end

	return positions
end

function M.create_window(row, col, bg_color)
	local buf = vim.api.nvim_create_buf(false, true)
	local window = vim.api.nvim_open_win(buf, false, {
		relative = "win",
		col = col,
		row = row - 1,
		width = 1,
		height = 1,
		focusable = false
	})
	vim.api.nvim_command("highlight MyHighlight guibg=" .. bg_color)
	vim.api.nvim_win_set_option(window, 'winhighlight', 'Normal:MyHighlight,FloatBorder:MyHighlight')
end

return M