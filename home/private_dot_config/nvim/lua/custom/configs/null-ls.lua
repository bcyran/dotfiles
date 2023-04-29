local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- lua
  b.formatting.stylua,

  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettier,

  -- shell
  b.diagnostics.shellcheck.with {
    extra_args = {
      "--enable=avoid-nullary-conditions,require-variable-braces,require-double-brackets",
      "--exclude=SC1091",
    },
  },
  b.formatting.shfmt.with {
    extra_args = { "-i", "4", "-bn", "-ci", "-sr" },
  },

  -- python
  b.diagnostics.flake8,
  b.diagnostics.mypy.with {
    temp_dir = "/tmp",
  },
  b.formatting.black,
  b.formatting.isort,

  -- rust
  b.formatting.rustfmt,

  -- go
  b.diagnostics.golangci_lint,
  b.formatting.golines.with {
    extra_args = {
      "--max-len=180",
      "--base-formatter=gofumpt",
    },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
