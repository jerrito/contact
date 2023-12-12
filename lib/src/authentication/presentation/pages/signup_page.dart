import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text("Signup"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes().height(context, 0.02)),
          child: Column(
            children: [
              DefaultTextfield(controller: controller, label: "First Name",hintText: "Enter your first name",),
              DefaultTextfield(controller: controller, label: "Last Name",
                  hintText: "Enter your last name"),
              DefaultTextfield(controller: controller, label: "Phone Number",
                  hintText: "Enter your phone number"),
              DefaultTextfield(controller: controller, label: "Email",
                  hintText: "Enter your email"),
              Space().height(context,0.02),
              const DefaultButton(
                onPressed: null,
                label: "Signup",
          
              ),
          
            ],
          ),
        ));
  }
}
