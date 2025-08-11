---@brief
---
--- https://github.com/godotengine/godot
---
--- Language server for GDScript, used by Godot Engine.

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  -- vim.fn.serverstart './godothost'
  vim.lsp.enable("gdscript")
end

local port = os.getenv 'GDScript_Port' or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))

return {
  cmd = cmd,
  filetypes = { 'gd', 'gdscript', 'gdscript3' },
  root_markers = { 'project.godot', '.git' },
}
