import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class Signin extends UseCases<QuerySnapshot<User>,Map<String,dynamic>> {
  final AuthenticationRepository repository;

  Signin({required this.repository});
  
  @override
  Future<Either<String, QuerySnapshot<User>>> call(Map<String, dynamic> params) async{
    return await repository.signIn(params);
  }
  
  }
