import 'package:house_rental/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.id,
    required super.token,
    required super.password
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        id: json["id"],
        token:json["token"],
        password:json["password"]
      );

  @override
  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name":lastName,
        "email":email,
        "phone_number":phoneNumber,
        "id":id,
        "token":token,
        "password":password
      };
}
