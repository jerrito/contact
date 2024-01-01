import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeLocalDatasource {
  Future<XFile> getProfileImageCamera();
  Future<XFile> getProfileImageGallery();
  Future<String> upLoadImage(Map<String, dynamic> params);
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  @override
  Future<XFile> getProfileImageCamera() async {
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result != null) {
      // Uint8List? fileBytes = result.files.first.bytes;
      // String fileName = result.files.first.name;

      // Upload file
      //   final upLoad = await FirebaseStorage.instance
      //       .ref(params["phone_number"])
      //       .child(fileName)
      //       .putData(fileBytes!);

      //  final url=await upLoad.ref.getDownloadURL();
      XFile file = XFile(result.path);
      return file;
    } else {
      throw Exception("Error getting image");
    }
  }

  @override
  Future<XFile> getProfileImageGallery() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      XFile file = XFile(result.path);
      return file;
    } else {
      throw Exception("Error getting image");
    }
  }

  @override
  Future<String> upLoadImage(Map<String, dynamic> params) async {
   

    //Upload file
    final upLoad = await FirebaseStorage.instance
        .ref()
        .child(params["phone_number"])
        .child(params["path"])
        .putFile(File(params["path"]));

    return await upLoad.ref.getDownloadURL();
  }
}
