
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/home/domain/usecases/get_profile_camera.dart';
import 'package:house_rental/src/home/domain/usecases/get_profile_gallery.dart';
import 'package:house_rental/src/home/domain/usecases/up_load_image.dart';
import 'package:image_picker/image_picker.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProfileCamera getProfileCamera;
  final GetProfileGallery getProfileGallery;
  final UpLoadImage upLoadImage;
  HomeBloc({
    required this.getProfileCamera,
    required this.getProfileGallery,
    required this.upLoadImage,
  }) : super(HomeInitState()) {
    //!GET PROFILE Camera
    on<GetProfileCameraEvent>((event, emit) async {
      final response = await getProfileCamera.call(event.params);

      emit(response.fold((error) => GetProfileError(errorMessage: error),
          (response) => GetProfileLoaded(file: response)));
    });

    //!GET PROFILE Gallery
    on<GetProfileGalleryEvent>((event, emit) async {
      final response = await getProfileGallery.call(event.params);

      emit(response.fold((error) => GetProfileError(errorMessage: error),
          (response) => GetProfileLoaded(file: response)));
    });

    on<UpLoadImageEvent>((event, emit) async {
     
      emit(UpLoadImageLoading());

      final response = await upLoadImage.call(event.params);

      emit(response.fold((error) => UpLoadImageError(errorMessage: error),
          (response) => UpLoadImageLoaded(imageURL: response)));
    });
  }
}
