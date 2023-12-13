import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/pages/otp_page.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:house_rental/src/home/presentation/pages/home_page.dart';
import 'package:oktoast/oktoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final authBloc = locator<AuthenticationBloc>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Signup"),
        ),
        bottomSheet: bottomSheetButton(
          context: context,
          label: "Signup",
          onPressed: () {
            final users = UserModel(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                phoneNumber: "+233${phoneNumberController.text}",
                id: "11");
            authBloc.add(SignupEvent(users: users));
          },
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is GenericError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
              if (state is HomePageGet) {
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return const HomePage();
                }));
              }
              if (state is SignupLoaded) {
                //GoRouter.of(context).go(location)
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return OTPPage(
                      name: "",
                      forceResendingToken: state.forceResendingToken,
                      verifyId: state.verificationId);
                }));
              }
            },
            builder: (context, state) {
              if (state is SignupLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes().height(context, 0.02)),
                  child: Column(
                    children: [
                      //firstName
                      DefaultTextfield(
                        controller: firstNameController,
                        label: "First Name",
                        hintText: "Enter your first name",
                      ),

                      //last Name
                      DefaultTextfield(
                          controller: lastNameController,
                          label: "Last Name",
                          hintText: "Enter your last name"),

                      //phone Number
                      DefaultTextfield(
                          textInputType: TextInputType.number,
                          controller: phoneNumberController,
                          label: "Phone Number",
                          hintText: "Enter your phone number"),

                      //email
                      DefaultTextfield(
                          controller: emailController,
                          label: "Email",
                          hintText: "Enter your email"),

                      Space().height(context, 0.02),
                    ],
                  ),
                ),
              );
            }));
  }
}
