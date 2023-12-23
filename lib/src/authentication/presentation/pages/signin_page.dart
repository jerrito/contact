import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/pages/otp_page.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:oktoast/oktoast.dart';

class SigninPage extends StatefulWidget {
  final String phoneNumber, uid;
  const SigninPage({
    super.key,
    required this.phoneNumber,
    required this.uid,
  });

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final authBloc = locator<AuthenticationBloc>();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocConsumer(
        bloc: authBloc,
        listener: (context, state) async {
          if (state is SigninLoaded) {}

          if (state is SigninError) {
            print(state.errorMessage);
            if (!context.mounted) return;

            OKToast(child: Text(state.errorMessage));
          }
        },
        builder: (context, state) {
          if (state is SigninLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return bottomSheetButton(
            context: context,
            label: "Signin",
            onPressed: () {
              Map<String, dynamic> number = {
                "phone_number": widget.phoneNumber
              };
              authBloc.add(SigninEvent(users: number));
            },
          );
        },
      ),
      body: BlocConsumer(
        listener: (context, state) {
          if (state is SigninLoaded) {
            debugPrint(state.user.id);
            //TODO: GET UID AGAIN
          }

          if (state is SigninError) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            context.goNamed("phoneNUmber");
          }
        },
        builder: (context, state) {
          if (state is SigninLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
