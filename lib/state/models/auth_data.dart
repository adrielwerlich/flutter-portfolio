class AuthData {
  final String? accessToken;
  final int? expiresIn;
  final int? expiresAt;
  final String? refreshToken;
  final String? tokenType;

  AuthData({
    this.accessToken,
    this.expiresIn,
    this.expiresAt,
    this.refreshToken,
    this.tokenType,
  });

  factory AuthData.fromJsonMap(Map<String, dynamic> json) {
    if (json.isEmpty) return AuthData();
    return AuthData(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
      expiresAt: json['expires_at'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
    );
  }

  factory AuthData.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return AuthData();
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
