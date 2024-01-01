import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental/src/home/presentation/pages/update_profile_page.dart';

buildProfileChangeBottomSheet(
  BuildContext context,
  HomeBloc homeBloc,
  User user,
) {
  return showModalBottomSheet(
      context: context,
      builder: ((context) {
        return Container(
            height: 200,
            padding: EdgeInsets.all(Sizes().width(context, 0.04)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space().height(context, 0.02),
                const Text("Update profile"),
                Space().height(context, 0.04),
                BlocConsumer(
                    bloc: homeBloc,
                    listener: (context, state) {
                      if (state is GetProfileError) {
                        debugPrint(state.errorMessage);
                      }
                      if (state is GetProfileLoaded) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UpdateProfilePage(
                            user: user,
                            imagePath: state.file.path,
                          );
                        }));
                      }
                    },
                    builder: (context, state) {
                      return DefaultButton(
                          label: "Camera",
                          onPressed: () {
                             Navigator.pop(context);
                            homeBloc
                                .add(GetProfileCameraEvent(params: NoParams()));
                          });
                    }),
                Space().height(context, 0.02),
                BlocConsumer(
                    bloc: homeBloc,
                    listener: (context, state) {
                      if (state is GetProfileError) {
                        debugPrint(state.errorMessage);
                      }
                      if (state is GetProfileLoaded) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UpdateProfilePage(
                            user: user,
                            imagePath: state.file.path,
                          );
                        }));
                      }
                    },
                    builder: (context, state) {
                      return DefaultButton(
                          label: "Gallery",
                          onPressed: () {
                            Navigator.pop(context);
                            homeBloc.add(
                                GetProfileGalleryEvent(params: NoParams()));
                          });
                    }),
              ],
            ));
      }));
}
