import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';

// ignore: must_be_immutable
class UpdateProfilePage extends StatefulWidget {
  final String imagePath;
  User? user;

  UpdateProfilePage({
    super.key,
    required this.imagePath,
    required this.user,
  });

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final homeBloc = locator<HomeBloc>();
  final authBloc = locator<AuthenticationBloc>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocConsumer(
          bloc: homeBloc,
          listener: (context, state) {
            if (state is UpLoadImageError) {
              debugPrint(state.errorMessage);
            }

            if (state is UpLoadImageLoaded) {
              Map<String, dynamic> params = {
                "id": widget.user!.id,
                "profile_url": widget.imagePath,
                "uid": widget.user!.uid,
                "first_name": widget.user!.firstName,
                "last_name": widget.user!.lastName,
                "email": widget.user!.email,
                "phone_number": widget.user!.phoneNumber,
              };
              authBloc.add(UpdateUserEvent(params: params));
            }

            if (state is UpdateUserLoaded) {
              debugPrint("cache");
              authBloc.add(const GetCacheDataEvent());
            }

            if (state is GetCacheDataLoaded) {
              debugPrint("user");
              widget.user = state.user;
              debugPrint(widget.user?.toMap().toString());
              setState(() {});
              Navigator.pop(context);
            }

            if (state is UpdateUserError) {
              debugPrint(state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is UpLoadImageLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return bottomSheetButton(
              context: context,
              label: "Save",
              onPressed: () {
                Map<String, dynamic> params = {
                  "phone_number": widget.user?.phoneNumber,
                  "path": widget.imagePath,
                };

                homeBloc.add(UpLoadImageEvent(params: params));
              },
            );
          }),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().width(context, 0.04),
        ),
        child: Column(
          children: [
            Space().height(context, 0.04),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Profile Picture",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(229, 229, 229, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: SvgPicture.asset(cancelSVG))),
            ]),

            Space().height(context, 0.125),

            CircleAvatar(
              radius: Sizes().height(context, 0.1875), // hS * 18.75,
              backgroundImage: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ).image,
            ),

            Space().height(context, 0.25),
            //SizedBox(height: hS * 25), //SizeConfig.blockSizeVertical*15),
          ],
        ),
      ),
    );
  }
}
