import 'package:equatable/equatable.dart';

class HouseDetail extends Equatable {
  final String? houseName, description;
  final num? amount, bedRoomCount, bathRoomCount;
  final List<String>? images;

  

  const HouseDetail({
    required this.houseName,
    required this.description,
    required this.amount,
    required this.images,
    required this.bedRoomCount,
    required this.bathRoomCount,
    
  });

  @override
  List<Object?> get props => [
        houseName,
        description,
        amount,
        bedRoomCount,
        bathRoomCount,
        images,
      ];
}


