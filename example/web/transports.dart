import "package:sock/sock.dart";

main() {
  print('starting sockjs');
  var transports = [SockTransport.XhrPolling];
  var options = new SockOptions()
    ..transports = transports;
  var s = new Sock('http://localhost:9999/echo', options);
  s.onopen.listen((_) => s.send('using transports: $transports'));
  s.onclose.listen((_) => print('closed'));
  s.onmessage.listen((msg){
    print("received: ${msg.data}");
    s.close();
  });
}


