import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeRepository {
  Future<Either<String, XFile>> getProfileImageGallery();
  Future<Either<String, XFile>> getProfileImageCamera();
  Future<Either<String, String>> upLoadImage(Map<String, dynamic> params);
}
