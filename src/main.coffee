

Bootstrap = require('./bootstrap.coffee').Bootstrap
Connection = require('./connection.coffee').Connection

node = 
  mirror: (data, res) -> 
    console.log 'node:mirror', data
    res(data)

  accept: (data, res) ->
    console.log 'node:accept', data

b = new Bootstrap (id, peers) ->
  c = new Connection(id, node)

  if(peers.length > 0)
    c.rpc peers[0], 'mirror', arg: 2, (data) ->
      console.log data

