import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';

class DefaultButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  const DefaultButton({super.key, this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes().height(context, 0.05),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label!),
      ),
    );
  }
}
