class DataMapperLocation {
  String? description;
  String? location;
  String? picture;
  User user;
  String? id;

  DataMapperLocation({
    this.description,
    this.location,
    this.picture,
    required this.user,
    this.id,
  });

  // factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory DataMapperLocation.fromJson(Map<String, dynamic> json) =>
      DataMapperLocation(
        description: json["description"],
        location: json["location"],
        picture: json["picture"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "location": location,
        "picture": picture,
        "user": user.toJson(),
      };
  DataMapperLocation copy() {
    return DataMapperLocation(
      description: description,
      location: location,
      picture: picture,
      user: user,
      id: id,
    );
  }
}

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
