module.exports =
  name: "Mother's Day"
  url: '/mothers/:from'
  fields: [
    { name: 'From', field: 'from'}
  ]

  register: (app, output) ->
    app.get '/mothers/:from', (req, res) ->
      message = "Happy Mother's Day!"
      subtitle = "- #{req.params.from}"
      output(req, res, message, subtitle)
