import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';

class HouseContainer extends StatelessWidget {
   const HouseContainer({super.key,});

@override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes().height(context,0.05),
      width: Sizes().width(context,0.08),
      decoration: BoxDecoration(),
      

    );
  }
}
