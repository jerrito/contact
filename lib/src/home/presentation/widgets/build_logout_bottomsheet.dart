import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';

buildLogoutBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: ((context) {
        final authBloc = locator<AuthenticationBloc>();
        return Container(
            height: 200,
            padding: EdgeInsets.all(Sizes().width(context, 0.04)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Log out of your account"),
                Space().height(context, 0.04),
                BlocConsumer(
                    listener: (context, state) {
                      if (state is UpdateUserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)));
                      }

                      if (state is UpdateUserLoaded) {
                        context.goNamed("signin");
                      }
                    },
                    bloc: authBloc,
                    builder: (context, state) {
                      if (state is UpdateUserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return DefaultButton(
                          label: "Log out",
                          onPressed: () {
                            Map<String, dynamic> params = {
                              "uid":null};
                            authBloc.add(UpdateUserEvent(params: params));
                          });
                    }),
                Space().height(context, 0.02),
                DefaultButton(
                    label: "Cancel",
                    onPressed: () {
                      context.pop();
                    })
              ],
            ));
      }));
}
