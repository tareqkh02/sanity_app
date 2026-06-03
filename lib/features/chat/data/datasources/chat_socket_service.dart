import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:safe_chat/core/constants/api_constants.dart';

class ChatSocketService {
  io.Socket? _socket;

  io.Socket init(String token) {
    _socket = io.io(
      ApiConstants.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setAuth({'token': '${ApiConstants.authHeaderPrefix}$token'})
          .build(),
    );

    _socket!.connect();

    _socket!.on('new-room', (data) => print('Room created: $data'));
    _socket!.on('get-message', (data) => print('New message: $data'));
    _socket!.on('error', (data) => print('Error: ${data['message']}'));
    _socket!.on('error-message',
        (data) => print('Send message error: ${data['message']}'));
    _socket!.on("new-message", (data) {
      print("New message received: $data");
    });
    _socket!.on('refresh-list', (data) {
      if (data['refreshList'] == true) {
        print('Chat list refresh requested');
      }
    });

    return _socket!;
  }

  io.Socket get socket {
    if (_socket == null) {
      throw Exception("Socket has not been initialized. Call init() first.");
    }
    return _socket!;
  }

  void createRoom(bool isGroup, String name, List<String> members) {
    socket.emit('new-room', {
      'isGroup': isGroup,
      'name': name,
      'members': members,
    });
  }

  void sendMessage(String chatId, String content, String receiverId) {
    socket.emit("message", [
      {"chatId": chatId, "content": content},
      receiverId,
    ]);
  }

  void dispose() {
    _socket?.dispose();
    _socket = null;
  }
}
