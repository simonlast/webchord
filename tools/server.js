
var http = require('http'),
	connect = require('connect'),
	express = require('express'),
	build = require('./build'),
	PeerServer = require('peer').PeerServer;



build.watch();

var app = express();

var oneDay = 86400000;

app.use(
  connect.static(__dirname + '/../public', { maxAge: oneDay })
);

var server = http.createServer(app);
server.listen(80);

var server = new PeerServer({ port: 9000 });