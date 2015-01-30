import "package:sock/sock.dart";

/*
var sock = new SockJS("http://localhost:9999/echo");
sock.onopen = function() {
    console.log('open');
    sock.send('test');
};
sock.onmessage = function(e) {
    console.log('message', e.data);
};
sock.onclose = function() {
    console.log('close');
};

window.setTimeout(function() {
   sock.close();
}, 1000);
*/

main() {
  print('starting sockjs');
  var s = new Sock('http://localhost:9999/echo');
  s.onopen.listen((_) => s.send('hello'));
  s.onclose.listen((_) => print('closed'));
  s.onmessage.listen((msg){
    print("received: ${msg.data}");
    s.close();
  });
}


