import 'package:dzero/config/mappers/user.dart';

class DataMapperLocation {
  String? description;
  String? location;
  String? picture;
  User user;
  String id;

  DataMapperLocation({
    this.description,
    this.location,
    this.picture,
    required this.user,
    required this.id,
  });

  factory DataMapperLocation.fromJson(Map<String, dynamic> json) =>
      DataMapperLocation(
        id: json["id"],
        description: json["description"],
        location: json["location"],
        picture: json["picture"],
        user: json["user"] == null
            ? User(email: '', name: '')
            : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "location": location,
        "picture": picture,
        "user": user.toJson(),
      };

  DataMapperLocation copy() {
    return DataMapperLocation(
      id: id,
      description: description,
      location: location,
      picture: picture,
      user: user,
    );
  }
}
