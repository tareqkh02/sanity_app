class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://sanity-chat.onrender.com';
  static const String authHeader = 'Issueebef67';
  static const String authHeaderPrefix = 'e0fe0eaff4ab8fc0 ';

  static const String signIn = '/api/public/auth/sign-in';
  static const String signUp = '/api/public/auth/sign-up';
  static const String chats = '/api/private/chat';
  static String chatById(String id) => '/api/private/chat/$id';
  static const String user = '/api/private/user';
  static const String searchUser = '/api/private/user/search';
  static const String decrypt = '/api/private/encrypt/decrypt';
}
