require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- The key-bindings here "i" allows to hold down the "Ctrl" key ot move around in 
-- "insert mode" without using the arrow keys
map("i", "jj", "<ESC>")
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>^i", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "lsp signature help" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
map("n", "<C-d>", "<cmd>RustMoveItemDown<CR>^n", { desc = "Rust move line down" })
map("n", "<C-u>", "<cmd>RustMoveItemUp<CR>^n", { desc = "Rust move line up" })
map("n", "<C-k>", vim.lsp.buf.hover, { desc = "lsp hover info" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical window" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- -- vim sourround
-- map({ "n", "v"}, "<leader>sa", function()
--   require("nvim-surround").add()
-- end, { desc = "surround add" })
--
-- map({ "n", "v"}, "<leader>sd", function()
--   require("nvim-surround").delete()
-- end, { desc = "surround delete" })
--
-- map({ "n", "v"}, "<leader>sc", function()
--   require("nvim-surround").change()
-- end, { desc = "surround change" })

-- code action
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "lsp code action" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- thePrimeagen's Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
map("n", "<leader>a", mark.add_file)
map("n", "<C-e>", ui.toggle_quick_menu)
map("n", "<C-h>", function()
  ui.nav_file(1)
end)
map("n", "<C-t>", function()
  ui.nav_file(2)
end)
map("n", "<C-nn>", function()
  ui.nav_file(3)
end)
map("n", "<C-s>", function()
  ui.nav_file(4)
end)

-- -- nvim-surround
-- map("n", "<leader>sa", require("nvim-surround").add_surround, { desc = "nvchad surround add" })
-- map("n", "<leader>sd", require("nvim-surround").delete_surround, { desc = "nvchad surround delete" })
-- map("n", "<leader>sc", require("nvim-surround").change_surround, { desc = "nvchad surround change" })
--
require("nvim-surround").setup({
    surrounds = {
        ["("] = false,
    },
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "ms",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
    },

})

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })


-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Auto resize panes when resizing nvim window
-- ...

vim.opt.list = true

for i = 1, 9, 1 do
  -- Move to desired buffer line using Alt + 1-9 keys
  vim.keymap.set("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end, { desc = "which_key_ignore" })
  -- Move to desired tab group instantly using Leader + 1-9 keys
  vim.keymap.set("n", string.format("<leader>%s", i), function()
    vim.api.nvim_set_current_tabpage(i)
  end, { desc = "which_key_ignore" })
end

--
-- ---@meta

-- ---@class ApiKeymapOpts
-- ---@field nowait? boolean If true, once the `lhs` is matched, the `rhs` will be executed
-- ---@field expr? boolean Specify whether the `rhs` is an expression to be evaluated or not (default false)
-----@field silent? boolean Specify whether `rhs` will be echoed on the command line
-----@field unique? boolean Specify whether not to map if there exists a keymap with the same `lhs`
-----@field script? boolean
-----@field desc? string Description for what the mapping will do
-----@field noremap? boolean Specify whether the `rhs` will execute user-defined keymaps if it matches some `lhs` or not
-----@field replace_keycodes? boolean Only effective when `expr` is **true**, specify whether to replace keycodes in the resuling string
-----@field callback function Lua function to call when the mapping is executed

-----@alias VimKeymapMode
-----|'"n"' # Normal Mode
-----|'"x"' # Visual Mode Keymaps
-----|'"s"' # Select Mode
-----|'"v"' # Equivalent to "xs"
-----|'"o"' # Operator-pending mode
-----|'"i"' # Insert Mode
-----|'"c"' # Command-Line Mode
-----|'"l"' # Insert, Command-Line and Lang-Arg
-----|'"t"' # Terminal Mode
-----|'"!"' # Equivalent to Vim's `:map!`, which is equivalent to '"ic"'
-----|'""'  # Equivalent to Vim's `:map`, which is equivalent to "nxso"

-----@class NvKeymapOpts : ApiKeymapOpts
-----@field remap? boolean inverse of `noremap`
-----@field buffer? integer|boolean|nil Specify the buffer that the keymap will be effective in. If 0 or true, the current buffer will be used
