

class Connection
	constructor: (id) ->
		@peers = {}
		@peer = new Peer(id, host: 'localhost', port: 9000);

		@peer.on 'connection', (conn) =>
			console.log conn

	#cb takes (res, err)
	rpc: (id, method, args, cb) ->
		if(@peers[id]?) #peer exists
			conn = @peer.connect(id);
			conn.on 'open', () =>
				@peers[id] = conn
				@send_rpc id, method, args, cb
		else
			@send_rpc id, method, args, cb

	send_rpc: (id, method, args, cb) ->
		@peers[id].send(id: id, method: method, args: args)


exports.Connection = Connection