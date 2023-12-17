import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class VerifyOTP extends UseCases<UserCredential,AuthCredential> {
  final AuthenticationRepository repository;
   VerifyOTP({required this.repository});
  @override
  Future<Either<String, UserCredential>> call(
      AuthCredential params) async {
    return await repository.verifyOTP(params);
  }
}
