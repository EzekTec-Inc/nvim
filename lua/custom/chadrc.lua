---@type ChadrcConfig
local M = {}
M.ui = {theme = 'catppuccin'}
M.plugins = 'custom.plugins'

-- In chadrc.lua
local plugins = {
    ["kyazdani42/nvim-web-devicons"] = {
        opt = true,
        config = function()
            require("nvim-web-devicons").setup {
                default = true;
            }
        end,
    },
}

return M
