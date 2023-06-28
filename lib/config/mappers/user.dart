class UserReporte {
  final String email;
  final String name;
  final String id;
  UserReporte({
    required this.email,
    required this.name,
    required this.id,
  });

  factory UserReporte.fromJson(Map<String, dynamic> json) => UserReporte(
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
