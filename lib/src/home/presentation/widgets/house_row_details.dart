import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';

class HouseRowDetails extends StatelessWidget {
  //final num bedRoomCount, bathhRoomCount, amount;
  //final String houseIMageURL;
  const HouseRowDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                
                borderRadius: BorderRadius.circular(10),
                child:Image.asset(
                      house1Image,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 100,
                    )
                
              ),
              Space().width(
                context,
                0.03,
              ),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Orchad House",
                        style: appTheme.textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w500, color: houseBlack100)),
                    Space().height(
                      context,
                      0.008,
                    ),
                    Text("RSP 250,000.00 / Year",
                        style: appTheme.textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: housePrimaryColor,
                            fontSize: 12)),
                    Space().height(
                      context,
                      0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          bedSVG,
                        ),
                        const Text(
                          "6 BedRoom",
                        ),
                        SvgPicture.asset(bathSVG),
                        const Text(
                          "4 BathRoom",
                        )
                      ],
                    )
                  ]),
            ]),

            Space().height(context, 0.025),
      ],
    );
  }
}
