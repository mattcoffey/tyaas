xmlEscape = require 'xml-escape'

module.exports =
  name: 'XML'
  mime: 'application/xml'

  render: (req, res) -> 
    res.set 'Content-Type', 'application/xml'
    res.send '<?xml version="1.0" encoding="UTF-8"?>
<tyaas:response xmlns:tyaas="http://api.tyaas.com/ty">
  <tyaas:message>'+xmlEscape(req.message)+'</tyaas:message>
  <tyaas:subtitle>'+xmlEscape(req.subtitle)+'</tyaas:subtitle>
</tyaas:response>'
