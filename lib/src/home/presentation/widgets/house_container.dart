import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/theme/colors.dart';

class HouseContainer extends StatelessWidget {
  const HouseContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 272,
      width: 222,
      child: Stack(
        children: [
          Container(
            height: 272,
            width: 222,
            decoration: BoxDecoration(
              // gradient: homeContainerGradient,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(22.0),
              image: DecorationImage(
                  image: Image.asset(
                houseImage,
                fit: BoxFit.contain,
                opacity: const AlwaysStoppedAnimation(.3),
              ).image),
            ),
            //child: ,
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  right: 12,
                ),
                child: Container(
                  width: 65,
                  decoration: BoxDecoration(
                    color: houseContainerRowColor,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          icLocationSVG,
                        ),
                        const Text(
                          "1.8 km",
                          style: TextStyle(
                            color: houseWhiteColor,
                          ),
                        )
                      ]),
                ),
              )),
          const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  bottom: 16,
                ),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    "DreamsVille House",
                    style: TextStyle(
                      color: houseWhiteColor,
                    ),
                  ),
                  Text(
                    "Jl. Sultan Iskandar Muda",
                    style: TextStyle(
                      color: houseWhiteColor,
                    ),
                  ),
                ]),
              ))
        ],
      ),
    );
  }
}
