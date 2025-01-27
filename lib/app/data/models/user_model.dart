class UserModel {
  final String id;
  final String password;
  final String name;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.password,
    required this.name,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'password': password,
        'name': name,
        'createdAt': createdAt.toIso8601String(),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        password: json['password'],
        name: json['name'],
        createdAt: DateTime.parse(json['createdAt']),
      );
}
