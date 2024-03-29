http = require("http")
connect = require("connect")
express = require("express")
build = require("./build")
PeerServer = require("peer").PeerServer
sio = require('socket.io')

build.watch()

app = express()
oneDay = 86400000

app.use connect.static(__dirname + "/../public",
  maxAge: oneDay
)
server = http.createServer(app)

io = sio.listen server, log: false

server.listen 80

peerserver = new PeerServer(port: 9000)

#bootstrapping
io.sockets.on 'connection', (socket) ->
	clients = io.sockets.clients().filter (s) -> s.id isnt socket.id
	uniq = clients.map (s) -> s.id
	console.log "client #{socket.id} connected"
	socket.emit 'init', id: socket.id, peers: uniq