return {
  -- Base copilot plugin
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    keys = {
      {
        "<leader>at",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
        end,
        desc = "Toggle Copilot auto trigger",
      },
    },
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-y>",
          accept_word = false,
          accept_line = "<C-m>",
          prev = "<C-p>",
          next = "<C-n>",
          dismiss = "<C-e>",
        },
      },
      filetypes = {
        rust = true,
        python = true,
        bash = true,
        lua = true,
        ["*"] = false,
      },
    },
    enabled = true,
    init = function()
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("menu_opened", function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.copilot_suggestion_hidden = true
        end)
        cmp.event:on("menu_closed", function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.copilot_suggestion_hidden = false
        end)
      end
    end,
  },

  -- Copilot chat plugin
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatTests",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatFixDiagnostic",
      "CopilotChatCommit",
      "CopilotChatCommitStaged",
      "CopilotChatBuffer",
    },
    opts = {
      proxy = os.getenv("http_proxy"),
      name = "Copilot",
      selection = function(source)
        return require("CopilotChat.select").visual(source)
      end,
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      -- Override default prompts
      opts.prompts = {
        Commit = {
          prompt = "Write commit message for the changes using conventional commit format",
          selection = select.gitdiff,
        },
        CommitStaged = {
          prompt = "Write commit message for the changes using conventional commit format",
          selection = function(source)
            return select.gitdiff(source, true)
          end,
        },
      }
      chat.setup(opts)

      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })
    end,
    keys = {
      {
        "<leader>av",
        function()
          local input = vim.fn.input("Chat about selection: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "Copilot chat about visual selection",
        mode = "v",
      },
      {
        "<leader>ab",
        function()
          local input = vim.fn.input("Chat about the buffer: ")
          if input ~= "" then
            vim.cmd("CopilotChatBuffer " .. input)
          end
        end,
        desc = "Copilot chat about current buffer",
      },
    },
  },

  -- Copilot indicator in statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local Util = require("lazyvim.util")
      local colors = {
        [""] = Util.ui.fg("Special"),
        ["Normal"] = Util.ui.fg("Special"),
        ["Warning"] = Util.ui.fg("DiagnosticError"),
        ["InProgress"] = Util.ui.fg("DiagnosticWarn"),
      }
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local icon = require("lazyvim.config").icons.kinds.Copilot
          local status = require("copilot.api").status.data
          return icon .. (status.message or "")
        end,
        cond = function()
          if not package.loaded["copilot"] then
            return
          end
          local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
          if not ok then
            return false
          end
          return ok and #clients > 0
        end,
        color = function()
          if not package.loaded["copilot"] then
            return
          end
          local status = require("copilot.api").status.data
          return colors[status.status] or colors[""]
        end,
      })
    end,
  },
}
