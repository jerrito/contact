import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:house_rental/core/firebase/firebase.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/authentication/data/data_source/remote_ds.dart';
import 'package:house_rental/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:house_rental/src/authentication/domain/usecases/signup.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_number.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';

final locator = GetIt.instance;

void initDependencies() {
  //bloc

  locator.registerFactory(
    () => AuthenticationBloc(
      firebaseAuth: locator(),
      signup: locator(),
      verifyNumber: locator(),
    ),
  );

  //usecases

  locator.registerLazySingleton(
    () => Signup(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(() => FirebaseAuth);

  locator.registerLazySingleton(
    () => VerifyPhoneNumber(
      repository: locator(),
    ),
  );
  //repository

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      firebaseService: locator(),
      networkInfo: locator(),
      remoteDatasource: locator(),
    ),
  );
  //remoteds

  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: locator(),
    ),
  );

  locator.registerLazySingleton<RemoteDatasource>(
    () => RemoteDatasourceImpl(),
  );

  locator.registerLazySingleton(
    () => DataConnectionChecker(),
  );

  locator.registerLazySingleton(
    () => FirebaseService(
      firebaseFirestore: locator(),
      firebaseAuth: locator(),
    ),
  );

  locator.registerLazySingleton(() => FirebaseFirestore.instance);

  locator.registerLazySingleton(() => FirebaseAuth.instance);
}
