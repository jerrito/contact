import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/assets/images/image_constants.dart';

class GalleryRow extends StatelessWidget {
  //final int itemCount;
  //final String image;
  const GalleryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 4,
        options:
            CarouselOptions(height: 70, reverse: true, viewportFraction: 0.3),
        itemBuilder: (context, index, value) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                house2Image,
                width: 80,
                height: 70,
                fit: BoxFit.cover,
              ));
        });
  }
}
