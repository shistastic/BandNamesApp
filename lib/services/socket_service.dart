import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket? _socket;
  IO.Socket? get socket => this._socket;

  SocketService() {
    print("INIT");
    this._initConfig();
  }

  void _initConfig() {
    _socket = IO.io(
      'http://192.168.1.187:3001',
      {
        "transports": ["websocket"],
        "autoConnect": true,
      },
    );
    _socket!.onConnect((_) {
      print('onConnect');
      _socket!.emit('msg', 'test');
    });
    _socket!.on('connect', (data) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket!.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
