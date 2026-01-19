
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move selected lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

-- Keep cursor in place when joining lines
vim.keymap.set('n', "J", "mzJ`z", { desc = 'Join lines' })

-- Keep cursor in place when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down half page' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up half page' })

-- Keep cursor in place when searching
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

-- Paste without yanking
vim.keymap.set('x' , '<leader>p', '"_dP', { desc = 'Paste without yanking' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


-- Disable arrow keys in all modes
-- local modes = { 'n', 'i', 'v', 'c', 't', 'o', 's', 'x' } -- All possible modes
local modes = { 'n', 'i', 'v', 'o', 't', 's', 'x' } -- All possible modes
local arrows = { '<Up>', '<Down>', '<Left>', '<Right>' }

for _, mode in ipairs(modes) do
  for _, key in ipairs(arrows) do
    vim.keymap.set(mode, key, '<Nop>', { noremap = true, silent = true })
  end
end

local enabledModes = { 'i', 'c', 'o', 't', 's', 'x' }
-- Map Alt + hjkl in Insert mode
for _, mode in ipairs(enabledModes) do
  vim.keymap.set(mode, '<A-h>', '<Left>', { noremap = true, silent = true })
  vim.keymap.set(mode, '<A-j>', '<Down>', { noremap = true, silent = true })
  vim.keymap.set(mode, '<A-k>', '<Up>', { noremap = true, silent = true })
  vim.keymap.set(mode, '<A-l>', '<Right>', { noremap = true, silent = true })
end
