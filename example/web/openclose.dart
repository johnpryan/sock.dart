import "dart:async";
import "package:sock/sock.dart";

main() {
  var s = openSock();
  setupHandlers(s);
}

Sock openSock() => new Sock('http://localhost:9999/echo');

setupHandlers(s) {
  s.onopen.listen((_) {
    s.send('hello');
  });
  s.onclose.listen((_){
    print('closed');
  });
  s.onmessage.listen((msg){
    print("received: ${msg.data}");
    s.close();
    new Future.delayed(new Duration(seconds: 1)).then((_) {
      s = openSock();
      setupHandlers(s);
    });
  });
}
