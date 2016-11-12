module.exports =
  name: "Cheers"
  url: '/cheers/:from'
  fields: [
    { name: 'From', field: 'from'}
  ]

  register: (app, output) ->
    app.get '/cheers/:from', (req, res) ->
      message = "Cheers!"
      subtitle = "- #{req.params.from}"
      output(req, res, message, subtitle)
