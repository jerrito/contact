import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class Signup extends UseCases {
  final AuthenticationRepository authenticationRepository;

  Signup({required this.authenticationRepository});
  @override
  Future<Either<String, dynamic>> call(params) async{
    return await authenticationRepository.signUp(params);
  }
}
