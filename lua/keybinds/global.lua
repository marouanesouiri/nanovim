local key = function(key, commands, desc)
	vim.keymap.set("", key, commands, { desc = desc or "" })
end

------------------------------------------------------------------------------

-- HEAD: intract with system clipboard
-- Paste
key("<Leader>p", '"+p', "Paste from system clipboard")
-- Yank
key("<Leader>y", '"+y', "Yank to system clipboard")
key("<Leader>yu", 'gg0vG$"+y', "Copy the buffer to system clipboard")
