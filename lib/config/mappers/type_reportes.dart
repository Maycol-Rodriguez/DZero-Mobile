import 'package:dzero/config/config.dart';

class Reporte {
  String? description;
  String location;
  String? picture;
  User user;
  String id;

  Reporte({
    this.description,
    required this.location,
    this.picture,
    required this.user,
    required this.id,
  });

  factory Reporte.fromJson(Map<String, dynamic> json) => Reporte(
        id: json["id"],
        description: json["description"],
        location: json["location"],
        picture: json["picture"],
        user: json["user"] == null ? User(email: '', name: '', id: '') : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "location": location,
        "picture": picture,
        "user": user.toJson(),
      };

  Reporte copyWith() {
    return Reporte(
      id: id,
      description: description,
      location: location,
      picture: picture,
      user: user,
    );
  }
}
