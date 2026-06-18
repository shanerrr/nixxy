local opts = { silent = true }

-- built-in comment (nvim 0.10+): map <C-/> to gcc/gc
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, silent = true })
vim.keymap.set("x", "<C-/>", "gc", { remap = true, silent = true })
vim.keymap.set("i", "<C-/>", "<Esc>gcca", { remap = true, silent = true })

-- toggleterm keymaps
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], opts)

-- diagnostics (global, set once)
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	severity_sort = true,
	float = { border = "rounded" },
})

-- LSP buffer-local keymaps. nvim 0.11 ships built-ins:
-- K (hover), grn (rename), gra (code action), grr (references),
-- gri (implementation), grt (type def), gd (definition via tagfunc).
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufopts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts)
	end,
})
