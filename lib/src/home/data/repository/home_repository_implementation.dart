
import 'package:dartz/dartz.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/home/data/data_source/localds.dart';
import 'package:house_rental/src/home/domain/repository/home_repository.dart';
import 'package:image_picker/image_picker.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final HomeLocalDatasource homeLocalDatasource;
  final NetworkInfo networkInfo;

  HomeRepositoryImplementation({
    required this.networkInfo,
    required this.homeLocalDatasource,
  });
  @override
  Future<Either<String, XFile>> getProfileImageGallery() async {
    try {
      final response = await homeLocalDatasource.getProfileImageGallery();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, XFile>> getProfileImageCamera() async {
    try {
      final response = await homeLocalDatasource.getProfileImageCamera();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> upLoadImage(
      Map<String, dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeLocalDatasource.upLoadImage(params);
        print(response);
        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetworkMessage);
    }
  }
}
