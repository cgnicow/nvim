local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'glepnir/zephyr-nvim', config = conf.zephyr })

package({
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'BufRead',
  config = conf.indent_blankline,
})
