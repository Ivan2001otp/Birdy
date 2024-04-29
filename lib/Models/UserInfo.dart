class UserInfo {
  final String name;
  final String uniqueId;
  final String email;
  String? photoUrl;
  String? nickName;
  int? age;
  bool? isActive = false;
  String? labelMessage;
  String? lastActiveTime;

  UserInfo({
    required this.name,
    required this.uniqueId,
    required this.email,
    this.photoUrl = '',
    this.nickName = '',
    this.age,
    this.isActive,
    this.labelMessage,
    this.lastActiveTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "photoUrl": photoUrl ?? '',
      "uid": uniqueId,
      "email": email,
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic>? json) {
    return UserInfo(
      name: json?['Name']! ?? 'no name',
      email: json?['Email'] ?? 'no email',
      photoUrl: json?['photoUrl'] ?? 'no photo',
      uniqueId: json?["Uid"],
    );
  }
}
