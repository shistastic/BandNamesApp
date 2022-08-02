import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _socketService = Provider.of<SocketService>(context);
    //

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SERVER STATUS: ${_socketService.serverStatus}",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          _socketService.socket!.emit(
            "emitir-mensaje",
            {"nombre": "Flutter", "mensaje": "Hola desde Flutter"},
          );
        },
        elevation: 1,
      ),
    );
  }
}
