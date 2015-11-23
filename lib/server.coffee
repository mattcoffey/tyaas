path = require 'path'
TYAAS = require path.resolve(__dirname,'tyaas')

tyaas = new TYAAS({
  renderersPath: path.resolve(__dirname,'renderers')
  filtersPath: path.resolve(__dirname,'filters')
  operationsPath: path.resolve(__dirname,'operations')
})

port = process.env.PORT || 5000

tyaas.start(port)
