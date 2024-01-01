part of 'home_bloc.dart';

class HomeState {}

class HomeInitState extends HomeState {}

class GetProfileLoaded extends HomeState {
  final XFile file;

  GetProfileLoaded({required this.file});
}

class GetProfileError extends HomeState {
  final String errorMessage;
  GetProfileError({required this.errorMessage});
}

class UpLoadImageLoading extends HomeState {}

class UpLoadImageError extends HomeState {
  final String errorMessage;
  UpLoadImageError({required this.errorMessage});
}

class UpLoadImageLoaded extends HomeState {
  final String imageURL;
  UpLoadImageLoaded({required this.imageURL});
}
