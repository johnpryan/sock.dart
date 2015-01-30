library sock;

import "dart:js" as js;
import "dart:async";

class SockTransport {
  static String WebSocket = 'websocket';
  static String XdrStreaming = 'xdr-streaming';
  static String XhrStreaming = 'xhr-streaming';
  static String IFrameEventSource = 'iframe-eventsource';
  static String IFrameHtmlFile = 'iframe-htmlfile';
  static String XdrPolling = 'xdr-polling';
  static String XhrPolling = 'xhr-polling';
  static String IFrameXhrPolling = 'iframe-xhr-polling';
  static String JsonpPolling = 'jsonp-polling';
}

class Sock {
  js.JsObject _sockjs;

  Sock(String url, [SockOptions options = null]) {
    List args;
    if (options == null) {
      args = [url];
    } else {
      args = [url, null, options.toJson()];
    }
    _sockjs = new js.JsObject(js.context['SockJS'], args);
  }

  Stream<SockEvent> get onopen => _callbackToStream(_sockjs, 'onopen');
  Stream<SockEvent> get onclose => _callbackToStream(_sockjs, 'onclose');
  Stream<SockEvent> get onmessage => _callbackToStream(_sockjs, 'onmessage');

  send(String data) => _sockjs.callMethod('send', [data]);
  close() => _sockjs.callMethod('close');
}

Stream<SockEvent> _callbackToStream(js.JsObject jsObj, String method) {
  StreamController controller = new StreamController();
  var cb = (e) {
    var evt = new SockEvent.fromJsObj(e);
    controller.add(evt);
  };
  jsObj[method] = cb;
  return controller.stream;
}

class SockEvent {
  String type;
  String data;
  SockEvent.fromJsObj(js.JsObject jsObj) {
    type = jsObj['type'];
    data = jsObj['data'];
  }
}

class SockOptions {
  List<String> transports;
  toJson() {
    Map m = {};
    if (transports != null) m['protocols_whitelist'] = transports;
    return new js.JsObject.jsify(m);
  }
}
