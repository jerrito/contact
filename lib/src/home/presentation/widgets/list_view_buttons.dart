import 'package:flutter/material.dart';
import 'package:house_rental/src/home/presentation/widgets/row_buttons.dart';

class ListViewRowButtons extends StatelessWidget {
  const ListViewRowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
       children: [
    
        RowButtons(isSelected: true,label: "House",),
        RowButtons(isSelected: true,label: "Apartment",),
        RowButtons(isSelected: false,label: "Hotel",),
        RowButtons(isSelected: false,label: "Villa",),
       ],
        //return const RowButtons(isSelected: true,label: "Home",);
      ),
    );
  }
}
