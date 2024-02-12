import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GalleryRow extends StatelessWidget {
  final int itemCount;
  final String image;
  const GalleryRow({super.key, required this.itemCount, required this.image});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: itemCount,
        options:
            CarouselOptions(height: 70, reverse: true, viewportFraction: 0.3),
        itemBuilder: (context, index, value) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
               image,
                width: 80,
                height: 70,
                fit: BoxFit.cover,
              ));
        });
  }
}
