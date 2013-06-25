
PeerData = require './peer.coffee'

###
Interface



###

class Connection
	constructor: (id, node) ->

		@node = node
		console.log node
		@peers = {}
		@peer = new Peer(id, host: 'localhost', port: 9000);

		# on new connection
		@peer.on 'connection', (conn) =>
			@peers[conn.peer] = conn
			@setupConnection conn
			console.log 'connection', conn
			console.log 'peers', @peers
			
		console.log "initialized Connection with id #{id}"

		# try to force the close event
		window.addEventListener 'onbeforeunload', =>
			@peer.close();

		#setInterval (() => @cleanup() ), 3000

	cleanup: ->
		console.log 'cleanup'
		console.log @peers
		for id, peer of @peers
			console.log peer

	setupConnection: (conn) ->
		conn.on 'data', (data) =>
			console.log 'data received', data
			if(data.rpc?)
				console.log 'received rpc', data.rpc
				# if(@node[data.rpc.method])
				# 	@node[data.rpc.method](data.args, (retVal) ->
				# 		console.log retVal)

		conn.on 'close', =>
			delete @peers[conn.peer]
			console.log 'connection closed'
			console.log 'peers', @peers

	#cb takes (res, err)
	rpc: (id, method, args, cb) ->
		if(not @peers[id]?) #peer exists
			conn = @peer.connect(id);
			conn.on 'open', () =>
				@peers[id] = conn
				@send_rpc id, method, args, cb
		else
			@send_rpc id, method, args, cb

	broadcast: (msg) ->
		for peer of @peers
			console.log peer

	send_rpc: (id, method, args, cb) ->
		@peers[id].send(rpc: { id: id, method: method, args: args})


exports.Connection = Connection