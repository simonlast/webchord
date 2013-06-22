
var id = '1';

peer = new Peer('qo4iew', {host: 'localhost', port: 9000});

console.log(id);

peer.on('connection', function(conn){
	console.log('connected to'  + conn);
	conn.on('data', function(data){
		console.log(data);
	});
});

peer.connect('1', function(conn){
	console.log('connected to ' + conn);
})


exports.peer = peer;