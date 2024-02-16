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

          
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            //search 
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
                  width: Sizes().width(context, 0.758),
                ),
              ),
            ),

            //menu icon
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

        //category row
         Row(
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
                width: Sizes().width(context, 0.20),
              ),
                     ),
           ],
         ),

         //house container
         Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.272),
            width: Sizes().width(context, 0.444),
          ),
        ),

        //text row
         Row(
           children: [

            //best for you
             Shimmer(
              gradient: gradient,
              child: SizedBox(                
                height: Sizes().height(context, 0.05),
                width: Sizes().width(context, 0.08),
              ),
                     ),
           ],
         ),
         

         //house listTiles
         Row(
           children: [
             Shimmer(
              gradient: gradient,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes().height(context, 0.005),
                  ),
                ),
                height: Sizes().height(context, 0.12),
                width: Sizes().width(context, 0.28),
              ),
                     ),

               Column(
                children:[
         
         //house name
         Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.02),
            width: Sizes().width(context, 0.08),
          ),
        ),

         //amount
         Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.015),
            width: Sizes().width(context, 0.2),
          ),
        ),

         //bed and bath count
         Shimmer(
          gradient: gradient,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Sizes().height(context, 0.005),
              ),
            ),
            height: Sizes().height(context, 0.02),
            width: Sizes().width(context, 0.6),
          ),
        ),
                ]
               )      
           ],
         ),
       
          ],
        ),

     
    );
  }
}
