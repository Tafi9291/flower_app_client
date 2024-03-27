import 'package:t_store/data/models/Users.dart';

class Role {
  int rolesId;
  String? rolesName;
  List<Users> users;

  Role({
    required this.rolesId,
    this.rolesName,
    this.users = const [],
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      rolesId: json['RolesId'],
      rolesName: json['RolesName'],
      users: json['Users'] != null ? List<Users>.from(json['Users'].map((x) => Users.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'RolesId': rolesId,
    'RolesName': rolesName,
    'Users': users.map((user) => user.toJson()).toList(),
  };
}
