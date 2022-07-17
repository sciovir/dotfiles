--------Commands config--------
-- Auto remove trailing spaces
vim.cmd([[
  augroup utils_user_config
    autocmd!
    " Auto remove trailing spaces
    autocmd BufWritePre * %s/\s\+$//e
    " Stop insert comment sign at new line automatically
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  augroup end
]])
--------End commands config--------
