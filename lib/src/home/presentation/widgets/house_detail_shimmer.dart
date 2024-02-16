import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:house_rental/core/size/sizes.dart";
import "package:shimmer/shimmer.dart";

class HouseDetailShimmer extends StatelessWidget {
  const HouseDetailShimmer({super.key});

  final gradient=const LinearGradient(
            colors: [
              Color.fromARGB(66, 224, 220, 220),
              Color.fromARGB(221, 143, 141, 141),
            ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //house container
        Shimmer(
          gradient: gradient,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Sizes().height(context, 0.015),
                ),
              ),
              height: Sizes().height(context, 0.34),
              width: double.infinity,
            ),
          ),
        ),

        //description
         Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.05),
            width: Sizes().width(context, 0.08),
          ),
        ),

        //description detail
        Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.003),
              ),
            ),
            height: Sizes().height(context, 0.04),
            width: Sizes().width(context, 0.012),
          ),
        ),

        Row(
          children: [

            //profile
            Shimmer(
              gradient: gradient,
              child: Container(
                decoration:const BoxDecoration(
                shape: BoxShape.circle
                ),
                height: Sizes().height(context, 0.05),
                width: Sizes().width(context, 0.10),
              ),
            ),
          
          //owner & role
            Column(
              children: [
                Shimmer(
                          gradient: gradient,
                          child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes().height(context, 0.005),
                  ),
                ),
                height: Sizes().height(context, 0.05),
                width: Sizes().width(context, 0.08),
                          ),
                        ),
              ],
            ),

          //phone icon
        Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.02),
            width: Sizes().width(context, 0.04),
          ),
        ),

  //mesage icon
        Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.02),
            width: Sizes().width(context, 0.04),
          ),
        ),
          ],
        ),

        //gallery text
        Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.02),
            width: Sizes().width(context, 0.04),
          ),
        ),

       //house gallery container
        Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.1),
            width: Sizes().width(context, 0.20),
          ),
        ),

        //map
        Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.20),
            width: Sizes().width(context, 1.0),
          ),
        ),

        //amount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer(
              gradient: gradient,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes().height(context, 0.005),
                  ),
                ),
                height: Sizes().height(context, 0.02),
                width: Sizes().width(context, 0.04),
              ),
            ),

            //button
            Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.02),
            width: Sizes().width(context, 0.04),
          ),
        ),
          ],
        ),

      ]),
    );
  }
}
