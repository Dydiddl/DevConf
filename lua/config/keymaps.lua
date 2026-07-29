local mapKey = require("utils.keyMapper").mapKey

-- neotree toggle
mapKey('<leader>e', ':Neotree toggle<cr>')

-- pane navigatrion
mapKey('<C-h>', '<C-w>h') -- Left
mapKey('<C-j>', '<C-w>j') -- Down
mapKey('<C-k>', '<C-w>k') -- Up
mapKey('<C-l>', '<C-w>l') -- Right

-- indent
mapKey('<', '<gv', 'v')
mapKey('>', '>gv', 'v')
