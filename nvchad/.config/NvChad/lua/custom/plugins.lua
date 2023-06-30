local plugins = {
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   config = function()
  --     require("kanagawa").setup()
  --     vim.cmd("colorscheme kanagawa")
  --   end
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      ensure_installed = {
        "python",
        "lua",
        "vim",
        "json",
        "yaml",
        "toml",
        "markdown",
        "html",
        "htmldjango",
        "css",
        "bash",
      }
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function (_, opts)
      local path = "~/.local/share/NvChad/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      local dap = require("dap")
      table.insert(dap.configurations.python, {
        name = "Docker remote attach",
        type = "python",
        request = "attach",
        connect = {
          port = 5678,
          host = "localhost",
        },
        mode = "remote",
        justMyCode = false,
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(),
            remoteRoot = ".",
          }
        }
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function ()
      return require("custom.configs.null-ls")
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "debugpy",
        "pyright",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  }
}
return plugins
