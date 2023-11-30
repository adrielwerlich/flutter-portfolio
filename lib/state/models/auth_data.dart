class AuthData {
  final String accessToken;
  final int expiresIn;
  final int expiresAt;
  final String refreshToken;
  final String tokenType;

  AuthData({
    required this.accessToken,
    required this.expiresIn,
    required this.expiresAt,
    required this.refreshToken,
    required this.tokenType,
  });

  factory AuthData.fromJsonMap(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
      expiresAt: json['expires_at'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
    );
  }

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['accessToken'],
      expiresIn: json['expiresIn'],
      expiresAt: json['expiresAt'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'expiresAt': expiresAt,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
    };
  }
}
