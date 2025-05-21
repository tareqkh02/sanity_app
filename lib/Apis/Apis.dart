import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:safe_chat/class/AuthProvider.dart';

Future<Map<String, dynamic>> signUpUser(String email, String password,
    String name, bool recall, BuildContext context) async {
  final url =
      Uri.parse('https://sanity-chat.onrender.com/api/public/auth/sign-up');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
      "name": name,
      "recall": recall,
    }),
  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    String? token = data['data']?['accessToken'];
    if (token != null) {
      Provider.of<AuthProvider>(context, listen: false).setAuthToken(token);
      print('Access token: $token');
      return {
        'success': true,
        'message': 'Sign-up successful',
        'token': token,
      };
    } else {
      print('Error: Access token is null');
      return {'success': false, 'message': 'Failed to sign up'};
    }
  } else {
    print("Failed to sign up: ${response.statusCode} - ${response.body}");
    return {'success': false, 'message': 'Failed to sign up'};
  }
}

Future<Map<String, dynamic>> signInUser(
    String email, String password, bool recall, BuildContext context) async {
  final url =
      Uri.parse('https://sanity-chat.onrender.com/api/public/auth/sign-in');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": email,
      "password": password,
      "recall": recall,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("User signed in successfully: ${response.body}");
    String? token = data['data']?['accessToken'];

    if (token != null) {
      print('Access token: $token');
      Provider.of<AuthProvider>(context, listen: false).setAuthToken(token);
    } else {
      print('Error: Access token is null');
    }

    return {'success': true, 'message': 'Login successful'};
  } else {
    print("Failed to sign In: ${response.statusCode} - ${response.body}");

    return {'success': false, 'message': 'Failed to sign In'};
  }
}

Future<Map<String, dynamic>?> createNewChat({
  String? name,
  String? image,
  required bool isGroup,
  String? adminId,
  required List<String> members,
  required BuildContext context,
}) async {
  final url = Uri.parse('https://sanity-chat.onrender.com/api/private/chat');
  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;

  if (authToken == null) {
    print("No auth token found.");
    return null;
  }

  final headers = {
    "Content-Type": "application/json",
    "Issueebef67": "e0fe0eaff4ab8fc0 $authToken"
  };
  final body = jsonEncode({
    'name': null,
    'image': null,
    'isGroup': false,
    'adminId': null,
    'members': members,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    print(' Chat created: ${data['data']['id']}');
    return data['data'];
  } else {
    print(' Error: ${response.statusCode}');
    return null;
  }
}

Future<String?> getChats(BuildContext context) async {
  final url = Uri.parse('https://sanity-chat.onrender.com/api/private/chat');
  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;

  if (authToken == null) {
    print("❌ No auth token found.");
    return null;
  }

  final headers = {"Issueebef67": "e0fe0eaff4ab8fc0 $authToken"};

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final chats = jsonResponse['data'];

      if (chats != null && chats.isNotEmpty) {
        final chatId = chats[0]['id']; // تأكد أن الـ key هو _id
        print("✅ Chat ID: $chatId");
        return chatId;
      } else {
        print("⚠️ No chats found.");
        return null;
      }
    } else {
      print("❌ Failed to fetch chats: ${response.statusCode}");
      print(response.body);
      return null;
    }
  } catch (e) {
    print("❌ Exception in getChats: $e");
    return null;
  }
}

Future<void> getLastChats(context) async {
  final url = Uri.parse('https://sanity-chat.onrender.com/api/private/chat');
  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;
  if (authToken == null) {
    print("No auth token found.");
  } else {
    print("The auth token: $authToken");
  }

  final headers = {"Issueebef67": "e0fe0eaff4ab8fc0 $authToken"};

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final chats = jsonResponse['data'];

      print(" Chats retrieved successfully:");
      for (var chat in chats) {
        print("Chat ID: ${chat['id']}, Participants: ${chat['participants']}");
      }
    } else {
      print(" Failed to retrieve chats. Status code: ${response.statusCode}");
      print(response.body);
    }
  } catch (e) {
    print(" Error occurred: $e");
  }
}

Future<Map<String, dynamic>> getChatById(String chatId, context) async {
  final url =
      Uri.parse('https://sanity-chat.onrender.com/api/private/chat/$chatId');

  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;

  final response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      'Issueebef67': 'e0fe0eaff4ab8fc0 $authToken',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final chat = data['data'];
    return chat;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized: Invalid token.');
  } else if (response.statusCode == 404) {
    throw Exception('Chat not found.');
  } else {
    throw Exception('Failed to fetch chat: ${response.statusCode}');
  }
}

Future<List<dynamic>> getAllChats(context) async {
  final url = Uri.parse('https://sanity-chat.onrender.com/api/private/chat');

  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;

  final response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      "Issueebef67": "e0fe0eaff4ab8fc0 $authToken",
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data);
    final List chats = data['data'];

    return chats;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized  Invalid token.');
  } else {
    throw Exception('Failed to fetch chats: ${response.statusCode}');
  }
}


Future<String?> getChatIdByUserId(BuildContext context, String userId) async {
  final url = Uri.parse('https://sanity-chat.onrender.com/api/private/chat');

  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;

  final response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      "Issueebef67": "e0fe0eaff4ab8fc0 $authToken",
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List chats = data['data'];

    for (var chat in chats) {
      List participants = chat['participants'];
      if (participants.contains(userId)) {
        return chat['id'];
      }
    }

    return null;
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized  Invalid token.');
  } else {
    throw Exception('Failed to fetch chats: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> searchUsers(String query, context) async {
  final url = Uri.parse(
      'https://sanity-chat.onrender.com/api/private/user/search?search=$query');

  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;
  if (authToken == null) {
    print("No auth token found.");
  } else {
    print("The auth token: $authToken");
  }

  final headers = {"Issueebef67": "e0fe0eaff4ab8fc0 $authToken"};

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final body = json.decode(response.body);
    final List data = body['data'];
    return data.cast<Map<String, dynamic>>();
  } else if (response.statusCode == 401) {
    throw Exception('Unauthorized');
  } else {
    throw Exception('Server error: ${response.statusCode}');
  }
}

Future<String?> getUserId(BuildContext context) async {
  final url = Uri.parse('https://sanity-chat.onrender.com/api/private/user/');
  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;

  if (authToken == null) {
    print("No auth token found.");
    return null;
  }

  final headers = {"Issueebef67": "e0fe0eaff4ab8fc0 $authToken"};

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final userId = jsonResponse['data']['id'].toString();
      print("✅ User ID: $userId");
      return userId;
    } else {
      print("❌ Failed to retrieve user. Status code: ${response.statusCode}");
      print(response.body);
      return null;
    }
  } catch (e) {
    print("❌ Error occurred: $e");
    return null;
  }
}

Future<String?> decryptText(context, String aesText) async {
  final url =
      Uri.parse('https://sanity-chat.onrender.com/api/private/encrypt/decrypt');
  String? authToken =
      Provider.of<AuthProvider>(context, listen: false).authToken;
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Issueebef67": "e0fe0eaff4ab8fc0 $authToken"
      },
      body: jsonEncode({
        'encryptedText': aesText,
      }),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['data'];
    } else {
      print('Failed with status: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error during request: $e');
    return null;
  }
}
