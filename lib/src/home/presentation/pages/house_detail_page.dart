import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/gallery_row.dart';
import 'package:house_rental/src/home/presentation/widgets/house_detail_container.dart';
import 'package:house_rental/src/home/presentation/widgets/owner_row_detail.dart';
import 'package:go_router/go_router.dart';

class HouseDetailPage extends StatefulWidget {
  final String? id;

  const HouseDetailPage({
    super.key,
    this.id,
  });

  @override
  State<HouseDetailPage> createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
  final homeBloc = locator<HomeBloc>();
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> params = {"id": widget.id};
    homeBloc.add(GetHouseEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
          listener: (context, state) {

          },
          bloc: homeBloc,
          builder: (context, state) {
            if (state is GetHouseLoading) {
              return const Center(
                child: CircularProgressIndicator());
            }
            if (state is GetHouseLoaded) {
              final data=state.houseDetail;
            return SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes().width(context, 0.04),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space().height(context, 0.05),
                      HouseDetailContainer(
                        arrowBackOnTap: () {
                          context.pop();
                        },
                        favouriteOnTap: null,
                      ),
                      Space().height(context, 0.020),
                      Text(
                        "Description",
                        style: appTheme.textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w500, color: houseBlack100),
                      ),
                      Space().height(context, 0.020),
                      Text(
                        data?.description ?? "",
                        style: appTheme.textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: searchTextColor1,
                            fontSize: 12),
                      ),
                      Space().height(context, 0.024),
                      OwnerRowDetails(
                        ownerName: data?.owner?.firstName,
                        ownerPhotoURL: data?.images?[0],
                        role: data?.description,
                        callOnTap: () {},
                        messageOnTap: () {},
                      ),
                      Space().height(context, 0.022),
                      Text(
                        "Gallery",
                        style: appTheme.textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w500, color: houseBlack100),
                      ),
                      Space().height(context, 0.018),
                      GalleryRow(
                        itemCount: (data?.images?.length ?? 1),
                        image: data?.images?[0] ?? "",
                      ),
                      Space().height(context, 0.022),
                      Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: searchTextColor1,
                              borderRadius: BorderRadius.circular(10)),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          )),
                      Space().height(context, 0.004),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("GHS ${data?.amount} / Year",
                              style: appTheme.textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: houseBlack100,
                              )),
                          const SizedBox(
                            width: 120,
                            height: 50,
                            child: DefaultButton(
                              label: "Rent Now",
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            );}
            return SizedBox();
          }),
    );
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.2, 0.085749655962),
    zoom: 14.4746,
  );
}
