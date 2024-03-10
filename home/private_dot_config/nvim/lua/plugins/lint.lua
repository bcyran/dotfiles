return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        python = { "flake8", "mypy" },
        sh = { "shellcheck" },
        go = { "golangcilint" },
      }

      lint.linters.shellcheck.args = {
        "--enable=avoid-nullary-conditions,require-variable-braces,require-double-brackets",
        "--exclude=SC1091",
        unpack(lint.linters.shellcheck.args),
      }

      lint.linters.flake8.args = {
        "--ignore",
        "E501,W503,E203",
        unpack(lint.linters.flake8.args),
      }

      lint.linters.mypy.args = {
        "--ignore-missing-imports",
        unpack(lint.linters.mypy.args),
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
