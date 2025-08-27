
if package.config:sub(1,1)=="\\" then
    vim.g.vimtex_view_general_viewer = 'C:/Users/erkag/AppData/Local/SumatraPDF/SumatraPDF.exe'
else
    vim.g.vimtex_view_method = "zathura"
end
vim.g.vimtex_compiler_method = "latexmk"
vim.g.maplocalleader = ","
vim.g.vimtex_fold_enabled = false
