import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class Signup extends UseCases<DocumentReference<User>?,Map<String,dynamic>> {
  final AuthenticationRepository authenticationRepository;

  Signup({required this.authenticationRepository});
  
  @override
  Future<Either<String, DocumentReference<User>?>> call(Map<String, dynamic> params) {
    return authenticationRepository.signIn(params);
  }
  
  }
