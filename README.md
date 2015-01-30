sock.dart 
=========

a dart wrapper for [sockjs-client](https://github.com/sockjs/sockjs-client)

## Usage

include the provided sockjs bundle in your HTML file:

```html
<script type="text/javascript" src="packages/sock/sockjs-0.3.4.min.js"></script>
```

then import and use:

```dart
import "package:sock/sock.dart";`
var s = new Sock('http://localhost:9999/echo');
s.onopen.listen((_) => s.send('hello'));
s.onclose.listen((_) => print('closed'));
s.onmessage.listen((msg){
  print("received: ${msg.data}");
  s.close();
});
```

