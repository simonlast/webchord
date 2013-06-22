

var path = require('path'),
	fs = require('fs')
	browserify = require('browserify'),
	watch = require('node-watch');

var dir = path.join(__dirname, '/../src/');
var main = path.join(dir, 'main.coffee');
var out = path.join(__dirname, '/../public/assets/webchord.js');

var coffee = require('coffee-script');
var through = require('through');

var br = browserify();
br.add(main);

br.transform(function (file) {
    var data = '';
    return through(write, end);

    function write (buf) { data += buf }
    function end () {
        this.queue(coffee.compile(data));
        this.queue(null);
    }
});

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