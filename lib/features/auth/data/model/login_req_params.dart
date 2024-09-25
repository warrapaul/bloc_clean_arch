import 'dart:convert';

String loginReqParamsToJson(LoginReqParams data) => json.encode(data.toJson());

class LoginReqParams {
  String email;
  String password;

  LoginReqParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
