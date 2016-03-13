module.exports =
  name: "I Love You"
  url: '/ilu/:name/:from'
  fields: [
    { name: 'Name', field: 'name'}
    { name: 'From', field: 'from'}
  ]

  register: (app, output) ->
    app.get '/ilu/:name/:from', (req, res) ->
      message = "I Love You #{req.params.name}."
      subtitle = "- #{req.params.from}"
      output(req, res, message, subtitle)
