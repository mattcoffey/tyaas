module.exports =
  name: "Well Done"
  url: '/wd/:name/:from'
  fields: [
    { name: 'Name', field: 'name'}
    { name: 'From', field: 'from'}
  ]

  register: (app, output) ->
    app.get '/wd/:name/:from', (req, res) ->
      message = "Well Done #{req.params.name}!"
      subtitle = "- #{req.params.from}"
      output(req, res, message, subtitle)
