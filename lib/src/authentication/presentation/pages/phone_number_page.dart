import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/pages/otp_page.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental/src/authentication/presentation/widgets/default_textfield.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final authBloc = locator<AuthenticationBloc>();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Verify Number")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
        
            Space().height(context, 0.030),
        
            const Text("Enter number to get a verification message"),
           
           Space().height(context, 0.030),

        
            DefaultTextfield(
              controller: phoneNumberController,
              label: "Enter Phone Number",
            ),
        
             Space().height(context, 0.030),
        
            BlocConsumer(
              bloc: authBloc,
              listener: (context, state) async {
                if (state is CodeSent) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OTPPage(
                      name: "",
                      forceResendingToken: state.token,
                      verifyId: state.verifyId,
                      onSuccessCallback: () {},
                    );
                  }));
                }
                if (state is CodeCompleted) {
                  // print("verification completed ${authCredential.smsCode}");
                  // print(" ${authCredential.verificationId}");
                  User? user = FirebaseAuth.instance.currentUser;
        
                  if (state.authCredential.smsCode != null) {
                    try {
                      UserCredential credential =
                          await user!.linkWithCredential(state.authCredential);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'provider-already-linked') {
                        await FirebaseAuth.instance
                            .signInWithCredential(state.authCredential);
                      }
                    }
                  }
                }
        
                if (state is GenericError) {
                  print(state.errorMessage);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                if (state is VerifyPhoneNumberLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
        
                return DefaultButton(
                  label: "Validate",
                  onPressed: () {
                    authBloc.add(PhoneNumberEvent(
                        phoneNumber: "+233${phoneNumberController.text}"));
                  },
                );
              },
            )
          ]),
        ));
  }
}