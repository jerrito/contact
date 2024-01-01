part of 'home_bloc.dart';

class HomeEvent {}

class GetProfileGalleryEvent extends HomeEvent {
  final NoParams params;
  GetProfileGalleryEvent({required this.params});
}

class GetProfileCameraEvent extends HomeEvent {
  final NoParams params;
  GetProfileCameraEvent({required this.params});
}

class UpLoadImageEvent extends HomeEvent {
  final Map<String, dynamic> params;
  UpLoadImageEvent({required this.params});
}
