conn = require './connection.coffee'

# n is the identifier of a peer
# run = (dest, funcName, funcArgs, cb) ->
#   rpcID = generateID()
#   conn = peer.connect(dest)
#   conn.on "open", ->
#     conn.send
#       orig: myID()
#       funcName: funcName
#       funcArgs: funcArgs
#       id: rpcID

#   peer.on "connection", (conn) ->
#     conn.on "data", (data) ->
#       cb data  if data.id is rpcID

successor = finger[1].node

initFingerTable = (id) ->
  conn.rpc id, "find_successor", [finger[1].start], (res) ->
    finger[1].node = res