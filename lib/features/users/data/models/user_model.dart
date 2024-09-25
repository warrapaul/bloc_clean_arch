import 'dart:convert';
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String firstName;
  String middleName;
  String lastName;
  int nationalId;
  String email;
  String phoneNumber;
  String status;
  dynamic userProfile;
  Role role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nationalId,
    required this.email,
    required this.phoneNumber,
    required this.status,
    required this.userProfile,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        nationalId: json["nationalId"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        status: json["status"],
        userProfile: json["userProfile"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "nationalId": nationalId,
        "email": email,
        "phoneNumber": phoneNumber,
        "status": status,
        "userProfile": userProfile,
        "role": role.toJson(),
      };

      
}

class Role {
  String id;
  String name;
  String description;
  bool isActive;
  List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["isActive"],
        permissions: List<Permission>.from(
            json["permissions"].map((x) => Permission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "isActive": isActive,
        "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
      };
}

class Permission {
  String id;
  String name;

  Permission({
    required this.id,
    required this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

