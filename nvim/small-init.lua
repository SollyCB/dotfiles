-- vim.cmd.colorscheme('sol')

vim.g.mapleader = ' '
vim.g.localmapleader = ' '

-- Opts
vim.cmd("set grepprg=rg\\ --vimgrep\\ ");

vim.opt.expandtab  = true
vim.opt.tabstop    = 2
vim.opt.shiftwidth = 2

vim.opt.makeprg = './build.sh'

vim.opt.guicursor = ""

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.list = true
vim.opt.listchars = { trail = '·', nbsp = '␣', tab = '  '}
vim.opt.inccommand = 'split'

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

  t = function(map, out, desc)
    vim.keymap.set('t', map, out, desc)
  end,
}

Map.n('<Esc>', '<cmd>nohlsearch<CR>')
Map.t('<Esc>', '<c-\\><c-n>')

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

Map.n('<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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

-- Plugins
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  'tpope/vim-sleuth',
  {
    'Vonr/align.nvim',
    config = function()
      local align = require('align')

      vim.keymap.set('v', 'ac', function()
        align.align_to_char({preview = true, length = 1})
      end, {silent = true, desc = '[a]lign to [c]har'})

      vim.keymap.set('v', 'ad', function()
        align.align_to_char({preview = true, length = 2})
      end, {silent = true, desc = '[a]lign to [d]ouble char'})

      vim.keymap.set('v', 'as', function()
        align.align_to_char({preview = true, regex = false})
      end, {silent = true, desc = '[a]lign to [s]tring'})
    end
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup { }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

    end,
  },
  install = { missing = true },
  checker = { enabled = true }
})
