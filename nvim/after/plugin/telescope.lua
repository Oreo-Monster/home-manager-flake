require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-uu' -- **This is the added flag**
    }
  }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', function() builtin.find_files({find_command=rg,prompt_prefix="󰥨  "}) end)
vim.keymap.set('n', '<leader>pa', function() builtin.find_files({find_command=rg,no_ignore=true,hidden=true,prompt_prefix="󰥨  "}) end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.live_grep({prompt_prefix="󰥨  "});
end)
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
