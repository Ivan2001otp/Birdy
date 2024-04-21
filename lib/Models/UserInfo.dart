class UserInfo {
  final String name;
  final String uniqueId;
  String? photoUrl;
  String? nickName;
  int? age;
  bool? isActive = false;
  String? labelMessage;
  String? lastActiveTime;

  UserInfo({
    required this.name,
    required this.uniqueId,
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
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic>? json) {
    return UserInfo(
      name: json?['Name']! ?? 'no name',
      photoUrl: json?['photoUrl'] ?? 'no photo',
      uniqueId: json?["Uid"],
    );
  }
}
