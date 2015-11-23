renderer = require __dirname+'/../../lib/renderers/html'

describe "HTML Renderer", ->
  it "should have the correct name", ->
    expect(renderer.name).toEqual('HTML')

  it "should have the correct mime type", ->
    expect(renderer.mime).toEqual('text/html')

  describe 'render', ->

    it 'should call res.set with Content-Type header', ->
      req =
        message: 'ONE'
        subtitle: 'TWO'
      res =
        set: jasmine.createSpy()
        send: jasmine.createSpy()
      renderer.render(req,res)

      expect(res.set).toHaveBeenCalledWith('Content-Type', 'text/html')

    it 'should call res.send with correct params', ->
      req =
        message: 'ONE'
        subtitle: 'TWO'
      res =
        set: jasmine.createSpy()
        send: jasmine.createSpy()
      renderer.render(req,res)

      expect(res.send).toHaveBeenCalledWith('<!DOCTYPE html>
<html>
  <head>
    <title>TYAAS - ONE - TWO</title>
    <meta charset="utf-8">
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
  </head>

  <body style="margin-top:40px;">
    <div class="container">
      <div id="view-10">
        <div class="hero-unit">
          <h1>ONE</h1>
          <p><em>TWO</em></p>
        </div>
      </div>
    </div>
  </body>
</html>')
   
    it 'should sanitize params', ->
      req =
        message: '<one>ONE</one>'
        subtitle: '<two>TWO</two>'
      res =
        set: jasmine.createSpy()
        send: jasmine.createSpy()
      renderer.render(req,res)

      expect(res.send).toHaveBeenCalledWith('<!DOCTYPE html>
<html>
  <head>
    <title>TYAAS - &lt;one&gt;ONE&lt;/one&gt; - &lt;two&gt;TWO&lt;/two&gt;</title>
    <meta charset="utf-8">
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
  </head>

  <body style="margin-top:40px;">
    <div class="container">
      <div id="view-10">
        <div class="hero-unit">
          <h1>&lt;one&gt;ONE&lt;/one&gt;</h1>
          <p><em>&lt;two&gt;TWO&lt;/two&gt;</em></p>
        </div>
      </div>
    </div>
  </body>
</html>')
