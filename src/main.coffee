

Bootstrap = require('./bootstrap.coffee').Bootstrap
Connection = require('./connection.coffee').Connection

b = new Bootstrap (id, peers) ->
	c = new Connection(id)