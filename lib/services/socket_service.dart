import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  IO.Socket? _socket;

  factory SocketService() => _instance;

  SocketService._internal();

  IO.Socket init(String token) {
    _socket = IO.io(
        'https://sanity-chat.onrender.com',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setAuth({'token': 'e0fe0eaff4ab8fc0 $token'})
            .build());

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
        print('🔄 Chat list refresh requested');
      }
    });
    return _socket!;
  }

  IO.Socket get socket {
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
    print("Sending message: $content to chat: $chatId");
    socket.emit("message", [
      {
        "chatId": chatId,
        "content": content,
      },
      receiverId
    ]);
  }

  void dispose() {
    _socket?.dispose();
    _socket = null;
  }
}
