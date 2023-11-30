class UserData {
  final String? provider;
  final List<String>? providers;
  final String? aud;
  final String? confirmationSentAt;
  final String? confirmedAt;
  final String? createdAt;
  final String? email;
  final String? emailConfirmedAt;
  final String? id;
  final List<Map<String, dynamic>>? identities;
  final String? lastSignInAt;
  final String? phone;
  final String? role;
  final String? updatedAt;
  final Map<String, dynamic>? userMetadata;

  UserData({
    this.provider,
    this.providers,
    this.aud,
    this.confirmationSentAt,
    this.confirmedAt,
    this.createdAt,
    this.email,
    this.emailConfirmedAt,
    this.id,
    this.identities,
    this.lastSignInAt,
    this.phone,
    this.role,
    this.updatedAt,
    this.userMetadata,
  });

  factory UserData.fromJsonMap(Map<String, dynamic> json) {
    return UserData(
      provider: json['app_metadata']['provider'],
      providers: List<String>.from(json['app_metadata']['providers']),
      aud: json['aud'],
      confirmationSentAt: json['confirmation_sent_at'],
      confirmedAt: json['confirmed_at'],
      createdAt: json['created_at'],
      email: json['email'],
      emailConfirmedAt: json['email_confirmed_at'],
      id: json['id'],
      identities: List<Map<String, dynamic>>.from(json['identities']),
      lastSignInAt: json['last_sign_in_at'],
      phone: json['phone'],
      role: json['role'],
      updatedAt: json['updated_at'],
      userMetadata: Map<String, dynamic>.from(json['user_metadata']),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      provider: json['provider'],
      providers: List<String>.from(json['providers']),
      aud: json['aud'],
      confirmationSentAt: json['confirmationSentAt'],
      confirmedAt: json['confirmedAt'],
      createdAt: json['createdAt'],
      email: json['email'],
      emailConfirmedAt: json['emailConfirmedAt'],
      id: json['id'],
      identities: List<Map<String, dynamic>>.from(json['identities']),
      lastSignInAt: json['lastSignInAt'],
      phone: json['phone'],
      role: json['role'],
      updatedAt: json['updatedAt'],
      userMetadata: Map<String, dynamic>.from(json['userMetadata']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'providers': providers,
      'aud': aud,
      'confirmationSentAt': confirmationSentAt,
      'confirmedAt': confirmedAt,
      'createdAt': createdAt,
      'email': email,
      'emailConfirmedAt': emailConfirmedAt,
      'id': id,
      'identities': identities,
      'lastSignInAt': lastSignInAt,
      'phone': phone,
      'role': role,
      'updatedAt': updatedAt,
      'userMetadata': userMetadata,
    };
  }
}
