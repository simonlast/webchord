path = require("path")
fs = require("fs")
browserify = require("browserify")
watch = require("node-watch")

dir = path.join(__dirname, "/../src/")
main = path.join(dir, "main.coffee")
out = path.join(__dirname, "/../public/assets/webchord.js")
coffee = require("coffee-script")
through = require("through")
br = browserify()
br.add main
br.transform (file) ->
  write = (buf) ->
    data += buf
  end = ->
    @queue coffee.compile(data)
    @queue null
  data = ""
  return through(write, end)

outStream = fs.createWriteStream(out)
exports.build = ->
  br.bundle().pipe outStream
  outStream = fs.createWriteStream(out)
  console.log "wrote " + out

exports.watch = ->
  exports.build()
  watch dir, (filename) ->
    exports.build()
