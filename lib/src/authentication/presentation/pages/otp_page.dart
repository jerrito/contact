// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';

class OTPPage extends StatefulWidget {
   String? verifyId, phoneNumber, name;
  int? forceResendingToken;
  void Function()? onSuccessCallback;
   OTPPage({
    Key? key,
    this.verifyId,
    this.phoneNumber,
    required this.name,
    this.forceResendingToken,
    this.onSuccessCallback,
  }) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:Text(widget.phoneNumber!)
          ),
          Space().height(context,0.04),
           Center(
            child:Text(widget.forceResendingToken.toString())
          ),
          Space().height(context,0.04),
           Center(
            child:Text(widget.verifyId!)
          ),

        ],
      ),
    );
  }
}