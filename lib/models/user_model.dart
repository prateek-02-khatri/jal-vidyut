class UserModel {
  final String username;
  final String userId;
  final String imageUrl;
  final String email;
  final String password;
  final String phoneNumber;
  final String tankHeight;
  final String tankWidth;
  final String tankCapacity;

  UserModel({
    required this.username,
    required this.userId,
    required this.imageUrl,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.tankHeight,
    required this.tankWidth,
    required this.tankCapacity
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'imageUrl': imageUrl,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'tankHeight': tankHeight,
      'tankWidth': tankWidth,
      'tankCapacity': tankCapacity,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {

    return UserModel(
        username: map['username'] ?? '',
        userId: map['userId'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        tankHeight: map['tankHeight'] ?? '0',
        tankWidth: map['tankWidth'] ?? '0',
        tankCapacity: map['tankCapacity'] ?? '0',
    );
  }
}
