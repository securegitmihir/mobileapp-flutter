abstract interface class AuthLocalProvider {
  Future<void> signOut();
  Future<String?> checkLoggedIn();
  Future<void> storeUpdatedUserInfo(String value);
}
