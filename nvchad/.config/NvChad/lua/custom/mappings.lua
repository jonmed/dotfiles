local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<F9>"] = {
      function () require("dap").toggle_breakpoint() end,
      desc = "Debugger: Toggle Breakpoint"
    },
    ["<F5>"] = {
      function () require("dap").continue() end,
      desc = "Debugger: Start"
    }
  }
}

return M
