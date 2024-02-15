import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:house_rental/core/size/sizes.dart";
import "package:shimmer/shimmer.dart";
class HouseDetailShimmer extends StatelessWidget {
  const HouseDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children:[
          Container(
            decoration: 
            BoxDecoration(borderRadius: BorderRadius.circular(5)),
            height:Sizes().height(context, 0.34),
      width: double.infinity,
       child: Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white54,
    child: Container(),
          )),

          
        ]
      ),
    );
  }
}