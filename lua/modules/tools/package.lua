local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
})

package({
  'nvimdev/hlsearch.nvim',
  event = 'BufRead',
  config = function()
    require('hlsearch').setup()
  end,
})
