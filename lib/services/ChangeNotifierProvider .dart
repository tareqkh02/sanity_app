
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../services/socket_service.dart';

class SocketProvider extends InheritedWidget {
  final Socket socket;

  const SocketProvider({
    Key? key,
    required this.socket,
    required Widget child,
  }) : super(key: key, child: child);

  static Socket of(BuildContext context) {
    final SocketProvider? provider =
        context.dependOnInheritedWidgetOfExactType<SocketProvider>();
    if (provider == null) {
      throw FlutterError('SocketProvider not found in context');
    }
    return provider.socket;
  }

  @override
  bool updateShouldNotify(SocketProvider oldWidget) => socket != oldWidget.socket;
}
