var http = require('http');
var sockjs = require('sockjs');
var node_static = require('node-static');

// 1. Echo sockjs server
var sockjs_opts = {sockjs_url: "http://cdn.jsdelivr.net/sockjs/0.3.4/sockjs.min.js"};

var sockjs_echo = sockjs.createServer(sockjs_opts);
sockjs_echo.on('connection', function(conn) {
    conn.on('data', function(message) {
        conn.write(message);
    });
    conn.on('close', function(_) {
        console.log('closed');
    });
});

// 2. Static files server
var static_directory = new node_static.Server("../build/web");

// 3. Usual http stuff
var server = http.createServer();
server.addListener('request', function(req, res) {
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:8888');
    static_directory.serve(req, res);
});
server.addListener('upgrade', function(req,res){
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:8888');
    res.end();
});

sockjs_echo.installHandlers(server, {prefix:'/echo'});

console.log(' [*] Listening on 0.0.0.0:9999' );
server.listen(9999, '0.0.0.0');
