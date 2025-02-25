import 'dart:convert';

String SignupReqDtoToJson(SignupReqDto data) =>
    json.encode(data.toJson());

class SignupReqDto {
  String firstName;
  String middleName;
  String lastName;
  int nationalId;
  String email;
  String phoneNumber;
  String password;

  SignupReqDto({
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
