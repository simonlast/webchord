
class Bootstrap
	constructor: (cb) ->
		@socket = io.connect 'localhost'
		@socket.on 'init', (id, peers) -> 
			cb(id, peers)


exports.Bootstrap = Bootstrap