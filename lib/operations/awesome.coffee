module.exports =
  name: "Awesome"
  url: '/awesome/:from'
  fields: [
    { name: 'From', field: 'from'}
  ]

  register: (app, output) ->
    app.get '/awesome/:from', (req, res) ->
      message = "You are awesome."
      subtitle = "- #{req.params.from}"
      output(req, res, message, subtitle)
