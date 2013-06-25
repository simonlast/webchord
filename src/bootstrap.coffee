
class Bootstrap
	constructor: (cb) ->
		@socket = io.connect 'localhost'
		@socket.on 'init', (data) -> 
			cb(data.id, data.peers)


exports.Bootstrap = Bootstrap