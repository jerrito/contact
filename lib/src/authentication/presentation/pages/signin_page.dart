import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final authBloc=locator<AuthenticationBloc>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomSheet: bottomSheetButton(
          context: context,
          label: "Signin",
          onPressed: () {
            final users = {
              "last_name": passwordController.text,
              "email": emailController.text,
            };
           authBloc.add(SigninEvent(users: users));
          },
        ), 
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes().height(context, 0.04)
          ),
          child: Column(children: [
            //firstName
            DefaultTextfield(
              controller: emailController,
              label: "First Name",
              hintText: "Enter your first name",
            ),

            //last Name
            DefaultTextfield(
                controller: passwordController,
                label: "Last Name",
                hintText: "Enter your last name"),


          ])),
    );
  }
}
