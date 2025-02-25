import 'dart:convert';

String LoginReqDtoToJson(LoginReqDto data) => json.encode(data.toJson());

class LoginReqDto {
  String email;
  String password;

  LoginReqDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
