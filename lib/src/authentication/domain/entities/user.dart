import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? firstName, lastName, email, id, phoneNumber;

  const User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.id});

  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber, id];

  toMap() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "id": id,
    };
  }
}
