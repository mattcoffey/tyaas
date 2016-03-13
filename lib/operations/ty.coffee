module.exports =
  name: "Thank You"
  url: '/ty/:name/:from'
  fields: [
    { name: 'Name', field: 'name'}
    { name: 'From', field: 'from'}
  ]

  register: (app, output) ->
    app.get '/ty/:name/:from', (req, res) ->
      message = "Thank You #{req.params.name}."
      subtitle = "- #{req.params.from}"
      output(req, res, message, subtitle)
