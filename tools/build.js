

var path = require('path'),
	fs = require('fs')
	browserify = require('browserify'),
	watch = require('node-watch');

var dir = path.join(__dirname, '/../src/');
var main = path.join(dir, 'main.js');
var out = path.join(__dirname, '/../public/assets/webchord.js');

var br = browserify();
br.add(main);

var outStream = fs.createWriteStream(out);

exports.build = function(){
	br.bundle().pipe(outStream);
	outStream = fs.createWriteStream(out);
	console.log('wrote ' + out);
};

exports.watch = function(){
	exports.build();
	watch(dir, function(filename){
		exports.build();
	});
};