import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:house_rental/core/firebase/firebase.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/authentication/data/data_source/local_ds.dart';
import 'package:house_rental/src/authentication/data/data_source/remote_ds.dart';
import 'package:house_rental/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:house_rental/src/authentication/domain/usecases/get_cache_data.dart';
import 'package:house_rental/src/authentication/domain/usecases/signup.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_number.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_otp.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  //bloc

  locator.registerFactory(
    () => AuthenticationBloc(
      firebaseAuth: locator(),
      signup: locator(),
      verifyNumber: locator(),
      verifyOTP: locator(),
      getCacheData: locator(),
    ),
  );

  //usecases

  locator.registerLazySingleton(
    () => Signup(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => FirebaseAuth.instance,
  );

  locator.registerLazySingleton(
    () => VerifyPhoneNumber(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => VerifyOTP(
      repository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetCacheData(
      repository: locator(),
    ),
  );
  //repository

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      firebaseService: locator(),
      networkInfo: locator(),
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  //remoteds

  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: locator(),
    ),
  );

  locator.registerLazySingleton<AuthenticationLocalDatasource>(
    () => AuhenticationLocalDataSourceImpl(
      sharedPreferences: locator(),
    ),
  );

  locator.registerLazySingleton<AuthenticationRemoteDatasource>(
    () => AuthenticationRemoteDatasourceImpl(
      localDatasource: locator(),
      firebaseAuth: locator(),
    ),
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
  final sharedPreference = await SharedPreferences.getInstance();
  locator.registerLazySingleton(
    () => sharedPreference,
  );

  final firestore = FirebaseFirestore.instance;
  locator.registerLazySingleton(
    () => firestore,
  );
}
