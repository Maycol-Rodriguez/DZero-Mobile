class User {
  User({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  // factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
