class AuthSession {
  const AuthSession({
    required this.email,
    required this.displayName,
    required this.token,
  });

  final String email;
  final String displayName;
  final String token;
}
