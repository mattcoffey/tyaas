express = require 'express'
bodyParser  = require('body-parser')
methodOverride = require('method-override')
fs = require 'fs'
path = require 'path'
npmPackage = require path.resolve(__dirname,'../package.json')
_ = require 'underscore'

module.exports = class TYAAS

  VERSION: npmPackage.version

  constructor: (options) ->
    # Internal State.
    @operations = {}
    @operationsArray = []
    @formats = {}
    @formatsArray = []
    @filters = {}

    # Main App
    @app = express()

    # Plugin Paths
    renderersPath = options.renderersPath || 'renderers'
    filtersPath = options.filtersPath || 'filters'
    operationsPath = options.operationsPath || 'operations'

    # A man is not dead while his name is still spoken.
    @app.use (req, res, next) ->
      res.header 'X-Clacks-Overhead', 'GNU Terry Pratchett'
      next()
      
    # Standard Middleware
    @app.use(bodyParser.json({extended: true, strict: false}))
    @app.use(bodyParser.urlencoded({extended: true}))
    @app.use(bodyParser.text({extended: true}))
    @app.use(methodOverride())
    
    # Load Filters
    @loadFilters(filtersPath)

    # Send very permissive CORS headers.
    @app.use (req, res, next) ->
      res.header 'Access-Control-Allow-Origin', '*'
      res.header 'Access-Control-Allow-Methods', 'GET, OPTIONS'
      res.header 'Access-Control-Allow-Headers', 'Content-Type'
      next()

    # Operations
    @loadOperations(operationsPath)

    # All Public Resources.
    @app.use(express.static('./public'))

    # GET / and /index.html sends index HTML page.
    @app.get '/', @sendIndex
    @app.get 'index.html', @sendIndex

    # OPTIONS on any route sends CORS above and ends
    @app.options "*", (req, res) ->
      res.end()

    # Final case, send 622 Thanks very much
    @app.use @send622
    
    # Renderers
    @loadRenderers(renderersPath)

  send622: (req, res) =>
    res.status(622)
    @output(req, res, "622 - Thanks very much", 'Server thanks you for your request, but is sure you meant something else.')

  sendIndex: (req, res) ->
    res.sendfile("./public/index.html")

  loadRenderers: (path) =>
    for file in fs.readdirSync(path)
      renderer = require path+'/'+file
      @formatsArray.push renderer.mime
      @formats[renderer.mime] = renderer.render

  loadFilters: (path) =>
    for file in fs.readdirSync(path)
      filter = require path+'/'+file
      filter.register(@app) if filter.register?
      @filters[filter.name] = filter

    @filters = _(@filters).chain().sortBy('priority').value()

  loadOperations: (path) =>
    router = express.Router()
    for file in fs.readdirSync(path)
      operation = require path+'/'+file
      operation.register(router, @output, @VERSION)
      @operationsArray.push
        name: operation.name
        url: operation.url
        fields: operation.fields
      @operations[operation.url] = operation

    # /operations endpoint
    router.get '/operations', (req, res) =>
      res.send @operationsArray

    # Default Operation
    router.get '/:thing/:from', (req, res) =>
      message = "Thanks, #{req.params.thing}."
      subtitle = "- #{req.params.from}"
      @output(req, res, message, subtitle)

    @app.use(router)

  start: (port) =>
    @app.listen port
    console.log "TYAAS v#{@VERSION} Started on port #{port}"

  output: (req, res, message, subtitle) =>
    req.message = message
    req.subtitle = subtitle

    filters = []
    for filter in @filters
      filters.push filter if filter.applies(req) 

    final = @outputFinal
    rout = (req,res) =>
      (filters.pop() || @).process(req,res,rout)

    rout(req,res)

  process: (req,res) =>
    mime = req.accepts(@formatsArray)

    unless mime?
      res.status 406
      res.end()
      return

    @formats[mime](req, res)
    res.end()
