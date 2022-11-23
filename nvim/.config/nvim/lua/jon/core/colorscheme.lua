local status, kanagawa = pcall(require, 'kanagawa')
if not status then
  return
end
kanagawa.setup({
  dimInactive = true,
  globalStatus = true,
})

local status, _ = pcall(vim.cmd, 'colorscheme kanagawa')
if not status then
  print('Colorscheme not found!')
  return
end
