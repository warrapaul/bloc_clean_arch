import 'dart:convert';

String signupReqParamsToJson(SignupReqParams data) =>
    json.encode(data.toJson());

class SignupReqParams {
  String firstName;
  String middleName;
  String lastName;
  int nationalId;
  String email;
  String phoneNumber;
  String password;

  SignupReqParams({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nationalId,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "nationalId": nationalId,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
      };
}
