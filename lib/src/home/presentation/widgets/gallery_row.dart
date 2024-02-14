import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/core/size/sizes.dart';

class GalleryRow extends StatelessWidget {
  final int itemCount;
  final List<String> image;
  const GalleryRow({super.key, required this.itemCount, required this.image});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: itemCount,
        options:
            CarouselOptions(height:Sizes().height(context, 0.07), reverse: true, viewportFraction: 0.3),
        itemBuilder: (context, index, value) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
               image[index],
                width: Sizes().width(context, 0.16),
                height: Sizes().height(context, 0.07),
                fit: BoxFit.cover,
              ));
        });
  }
}
