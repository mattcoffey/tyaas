sanitizer = require 'sanitizer'

module.exports =
  name: 'HTML'
  mime: 'text/html'

  render: (req, res) ->
    message = sanitizer.escape(req.message)
    subtitle = sanitizer.escape(req.subtitle)
    res.set 'Content-Type', 'text/html'
    res.send '<!DOCTYPE html>
<html>
  <head>
    <title>TYAAS - '+message+' - '+subtitle+'</title>
    <meta charset="utf-8">
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
  </head>

  <body style="margin-top:40px;">
    <div class="container">
      <div id="view-10">
        <div class="hero-unit">
          <h1>'+message+'</h1>
          <p><em>'+subtitle+'</em></p>
        </div>
      </div>
    </div>
  </body>
</html>'
