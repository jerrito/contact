import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class Signin extends UseCases {
  final AuthenticationRepository authenticationRepository;

  Signin({required this.authenticationRepository});
  @override
  Future<Either<String, dynamic>> call(params) async{
   
   return await authenticationRepository.signIn(params);
  }
}
