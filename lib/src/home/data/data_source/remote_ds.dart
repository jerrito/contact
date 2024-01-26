import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental/src/home/data/models/house_model.dart';

abstract class HomeRemoteDatasource {
  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(Map<String, dynamic> params);
}

class HomeRemoteDatatsourceImpl extends HomeRemoteDatasource {
  @override
  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(Map<String, dynamic> params) async {
    final houseReference =
        await FirebaseFirestore.instance.collection("houseRentalAdmin")
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (house, _) => house.toMap(),
        )
        .get();

    return houseReference;
  }
}
