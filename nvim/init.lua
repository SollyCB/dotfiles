require("lazy-config")

vim.g.mapleader = ' '
vim.g.localmapleader = ' '

-- Opts
vim.cmd("set grepprg=rg\\ --vimgrep\\ ");

vim.opt.expandtab  = true
vim.opt.tabstop    = 4
vim.opt.shiftwidth = 4

vim.opt.makeprg = './build.sh'

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.list = true
vim.opt.listchars = { trail = '·', nbsp = '␣', tab = '  '}
vim.opt.inccommand = 'split'

-- vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.relativenumber = true

-- Binds
Map = {

  n = function(map, out, desc)
    vim.keymap.set('n', map, out, desc)
  end,

  i = function(map, out, desc)
    vim.keymap.set('i', map, out, desc)
  end,

  v = function(map, out, desc)
    vim.keymap.set('v', map, out, desc)
  end,

}

Map.n('<Esc>', '<cmd>nohlsearch<CR>')

Map.n('<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
Map.n('<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
Map.n('<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
Map.n('<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

Map.n('>', '>>', {})
Map.n('<', '<<', {})

Map.i('<M-c>', '// scb :- '          , {desc = 'Write regular comment'})
Map.i('<M-s>', '// Suggestion(scb): ', {desc = 'Write SUGGESTION comment'})
Map.i('<M-t>', '// Todo(scb): '      , {desc = 'Write TODO comment'})
Map.i('<M-e>', '// Experiment(scb): ', {desc = 'Write EXPERIMENT comment'})
Map.i('<M-n>', '// Note(scb): '      , {desc = 'Write NOTE comment'})
Map.i('<M-b>', '// Bug(scb): '       , {desc = 'Write BUG comment'})
Map.i('<M-h>', '// hack(scb): '      , {desc = 'Write HACK comment'})

local paste_date = function()
  local date = os.date('*t')
  local string = string.format("%d-%d-%d", date.day, date.month, date.year);
  vim.api.nvim_paste(string, false, -1)
end

Map.i('<M-d>', paste_date, {desc = 'Write date into buffer as dd-mm-yy'});

Map.n('-', 'zt')
Map.n('_', 'zb')
Map.n('=', 'zz')

Map.n('/', '/\\V')

Map.n('<space>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Open file in last place
local last_place_ignore_buftype = { "quickfix", "nofile", "help" }
local last_place_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

local function last_place()
  if vim.tbl_contains(last_place_ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(last_place_ignore_filetype, vim.bo.filetype) then
    -- reset cursor to first line
    vim.cmd[[normal! gg]]
    return
  end

  -- If a line has already been specified on the command line, we are done
  --   nvim file +num
  if vim.fn.line(".") > 1 then
    return
  end

  local last_line = vim.fn.line([['"]])
  local buff_last_line = vim.fn.line("$")

  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = vim.fn.line("w$")
    local win_first_line = vim.fn.line("w0")
    -- Check if the last line of the buffer is the same as the win
    if win_last_line == buff_last_line then
      -- Set line to last line edited
      vim.cmd[[normal! g`"]]
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd[[normal! g`"zz]]
    else
      vim.cmd[[normal! G'"<c-e>]]
    end
  end
end

vim.api.nvim_create_autocmd({'BufWinEnter', 'FileType'}, {
  group = vim.api.nvim_create_augroup('lastplace', {}),
  callback = last_place
})

-- LSP type stuff
vim.diagnostic.config({
  update_in_insert = false,
  signs = false,
})

vim.api.nvim_create_autocmd({'ColorScheme'}, {
  group = vim.api.nvim_create_augroup('colorscheme', {}),
  callback = function()
    -- local y = '#90d5ff'
    -- local b = '#c7efc7'
    vim.api.nvim_set_hl(0, '@lsp.type.function', {})
    vim.api.nvim_set_hl(0, '@lsp.type.macro', {})
    vim.api.nvim_set_hl(0, '@lsp.type.property', {})
    vim.api.nvim_set_hl(0, '@lsp.type.string', {})
  end
})

vim.api.nvim_create_autocmd({'TermOpen'}, {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

vim.keymap.set('n', '<space>st', function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
end)

