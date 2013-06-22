
# n is the identifier of a peer
run = (dest, funcName, funcArgs, cb) ->
  rpcID = generateID()
  conn = peer.connect(dest)
  conn.on "open", ->
    conn.send
      orig: myID()
      funcName: funcName
      funcArgs: funcArgs
      id: rpcID


  peer.on "connection", (conn) ->
    conn.on "data", (data) ->
      cb data  if data.id is rpcID


initFingerTable = (id) ->
  rpc.run id, "find_successor", [finger[1].start], (res) ->

rpc = require("./rpc")
conn = require("./connection")