-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

map("n", ";", ":")
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostics
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Git
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Open [G]it status" })

-- File tree
map("n", "<leader>nt", "<cmd>Neotree toggle reveal<CR>", { desc = "File tree [T]oggle" })
map("n", "<leader>nf", "<cmd>Neotree reveal<CR>", { desc = "File tree [F]ind file" })

-- Format
map({ "n", "x" }, "<leader>f", function()
  LazyVim.format({ force = true })
end, { desc = "[F]ormat buffer" })

-- Search
map("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", function()
  Snacks.picker.files()
end, { desc = "[S]earch [F]iles" })
map("n", "<leader>st", function()
  Snacks.picker.git_files()
end, { desc = "[S]earch [T]racked files" })
map("n", "<leader>ss", function()
  Snacks.picker.pickers()
end, { desc = "[S]earch [S]elect picker" })
map({ "n", "x" }, "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", function()
  Snacks.picker.grep()
end, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", function()
  Snacks.picker.resume()
end, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", function()
  Snacks.picker.recent()
end, { desc = "[S]earch Recent Files" })
map("n", "<leader><leader>", function()
  Snacks.picker.buffers()
end, { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", function()
  Snacks.picker.lines()
end, { desc = "[/] Fuzzily search in current buffer" })
map("n", "<leader>s/", function()
  Snacks.picker.grep_buffers()
end, { desc = "[S]earch [/] in Open Files" })
map("n", "<leader>sn", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
