class User {
  final int userId;
  final String email;
  final String? passwordHash;
  final String userName;
  final String? phone;
  final DateTime? birthDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final int stampPoints;

  User({
    required this.userId,
    required this.email,
    this.passwordHash,
    required this.userName,
    this.phone,
    this.birthDate,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.stampPoints,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? json['userId'] ?? 0,
      email: json['email'] ?? '',
      passwordHash: json['password_hash'] ?? json['passwordHash'],
      userName: json['user_name'] ?? json['userName'] ?? '',
      phone: json['phone'],
      birthDate: json['birth_date'] != null || json['birthDate'] != null
          ? DateTime.parse(json['birth_date'] ?? json['birthDate'])
          : null,
      createdAt: json['created_at'] != null || json['createdAt'] != null
          ? DateTime.parse(json['created_at'] ?? json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null || json['updatedAt'] != null
          ? DateTime.parse(json['updated_at'] ?? json['updatedAt'])
          : DateTime.now(),
      status: json['status'] ?? 'active',
      stampPoints: json['stamp_points'] ?? json['stampPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'password_hash': passwordHash,
      'user_name': userName,
      'phone': phone,
      'birth_date': birthDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status,
      'stamp_points': stampPoints,
    };
  }

  User copyWith({
    int? userId,
    String? email,
    String? passwordHash,
    String? userName,
    String? phone,
    DateTime? birthDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    int? stampPoints,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      stampPoints: stampPoints ?? this.stampPoints,
    );
  }
}



