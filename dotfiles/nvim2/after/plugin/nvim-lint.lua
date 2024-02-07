require('lint').linters_by_ft = {
 markdown = {'vale',},
 dockerfile = {'hadolint',},
 sh = {'shellcheck',}
}

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
