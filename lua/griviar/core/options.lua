vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Add number to the left colomn
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Decrease update time
opt.updatetime = 250

-- turn on termguicolors for nightfly colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- backspace
opt.backspace = "indent,eol,start"

opt.inccommand = 'nosplit'

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
