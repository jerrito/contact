import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental/core/widgets/bottom_sheet.dart';

import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/pages/phone_number_page.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:oktoast/oktoast.dart';

class SigninPage extends StatefulWidget {
  final String phoneNumber, uid, id;
  const SigninPage(
      {super.key,
      required this.phoneNumber,
      required this.uid,
      required this.id});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final authBloc = locator<AuthenticationBloc>();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  bool isPhoneNumberLogin = true;
  @override
  void initState() {
    super.initState();
    authBloc.add(const GetCacheDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signin Page")),
      bottomSheet: BlocConsumer(
        bloc: authBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return bottomSheetButton(
            context: context,
            label: "Signin",
            onPressed: () {
              if (type == UseNumber.emailPassword) {
                var bites = utf8.encode(passwordController.text);
                var password = sha512.convert(bites);
                final users = {
                  "email": emailController.text,
                  "phone_number": widget.phoneNumber,
                  //"id": "",
                  "password": password.toString(),
                  "uid": widget.uid,
                };

                authBloc.add(
                  SignupEvent(users: users),
                );
              } else {
                Map<String, dynamic> number = {
                  "phone_number": widget.phoneNumber,
                };
                authBloc.add(
                  SigninEvent(users: number),
                );
              }
            },
          );
        },
      ),
      body: BlocConsumer(
        bloc: authBloc,
        listener: (context, state) async {
          if (state is SigninLoaded) {
            Map<String, dynamic> params = {
              "id": widget.id,
              "uid": widget.uid,
            };
            authBloc.add(
              UpdateUserEvent(params: params),
            );
          }

          if (state is SigninError) {
            debugPrint(state.errorMessage);
            if (!context.mounted) return;

            OKToast(child: Text(state.errorMessage));
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return const PhoneNumberPage(isLogin: true);
            })));
            //context.goNamed("phoneNumber");
          }
        },
        builder: (context, state) {
          if (state is SigninLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                RadioListTile(
                    value: UseNumber.phoneNumber,
                    groupValue: type,
                    title: const Text("Use Phone Number"),
                    onChanged: (value) {
                      type = value!;
                      setState(() {});
                    }),
                RadioListTile(
                    value: UseNumber.emailPassword,
                    groupValue: type,
                    title: const Text("Use Email and Password"),
                    onChanged: (value) {
                      //value = UseNumber.phoneNumber;
                      type = value!;
                      setState(() {});
                    }),
                Visibility(
                  visible: type != UseNumber.phoneNumber,
                  replacement: DefaultTextfield(
                    controller: phoneNumberController,
                    label: "Phone Number",
                  ),
                  child: Column(
                    children: [
                      //email
                      DefaultTextfield(
                        controller: emailController,
                        label: "Email",
                        hintText: "Enter your email",
                      ),

                      //password
                      DefaultTextfield(
                        controller: passwordController,
                        label: "Password",
                        hintText: "Enter your password",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  UseNumber type = UseNumber.phoneNumber;
}

enum UseNumber { phoneNumber, emailPassword }
