class User {
  final String email;
  final String name;
  final String id;
  User({
    required this.email,
    required this.name,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "id": id,
      };
}
