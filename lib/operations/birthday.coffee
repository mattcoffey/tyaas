module.exports =
  name: "Birthday"
  url: '/birthday/:name/:from'
  fields: [
    { name: 'Name', field: 'name'}
    { name: 'From', field: 'from'}
  ]

  register: (app, output) ->
    app.get '/birthday/:name/:from', (req, res) ->
      message = "Happy Birthday, #{req.params.name}!"
      subtitle = "- #{req.params.from}"
      output(req, res, message, subtitle)
