local options = {
  -- General
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  wrap = true,                             -- wrap lines that exceed buffer width 
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "hack:h17",                    -- the font used in graphical neovim applications

  -- Tabs
  expandtab = true,                        -- convert tabs to spaces
  tabstop = 4,                             -- visual spaces per tab 
  softtabstop = 4,                         -- number of spaces in tab when editing
  shiftwidth = 4,                          -- number of spaces from reindent ops (<<, >>)
  showtabline = 2,                         -- always show tabs
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[set iskeyword+=-]]
