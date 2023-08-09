import '../../api/api.dart';

class User {
  const User(
    this.name, {
    required this.isCaregiver,
  });

  User.fromJson(Json json)
      : name = json['name'] as String,
        isCaregiver = json['isCaregiver'] as bool;

  final String name;
  final bool isCaregiver;
}
