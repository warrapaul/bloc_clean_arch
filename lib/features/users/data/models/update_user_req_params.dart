import 'dart:convert';

String updateUserReqParamsToJson(UpdateUserReqParams data) =>
    json.encode(data.toJson());

class UpdateUserReqParams {
  String firstName;
  String middleName;
  String lastName;
  int nationalId;
  String email;
  String phoneNumber;

  UpdateUserReqParams({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nationalId,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "nationalId": nationalId,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
