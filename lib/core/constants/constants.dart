// API URL constants
class ApiUrls {
  static const String baseUrl = 'http://10.0.2.2:3002';

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String checkLoggedIn = '/auth/validate';
}

Map<int, String> apiErrorMessages = {
  400: 'Bad Request',
  401: 'Authentication failed',
  403: 'Authorization failed',
  404: 'Not Found',
  500: 'Internal Server Error',
};

class StorageKeys {
  static const String authUserKey = 'auth_user';
}

class RoutePaths {
  static const String home = '/home';
  static const String profile = '/profile';
  static const String auth = '/auth';
  // static const String intro = '/intro';
  static const String splash = '/';
  static const List<String> publicRoutes = [splash, auth];
  static const List<String> protectedRoutes = [home, profile];
}
