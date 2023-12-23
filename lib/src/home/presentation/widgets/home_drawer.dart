import 'package:flutter/material.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/src/home/presentation/widgets/drawer_list_tile.dart';

class HomeDrawer extends StatelessWidget {

  const HomeDrawer({super.key, });

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children:[

          DrawerHeader(
            child:Column(
            children:[
              Space().height(context,0.02),

              CircleAvatar(backgroundImage: Image.asset("").image,),
               Space().height(context,0.02),
              Text("FUllName"),
              Space().height(context,0.02),
              Text("Phone Number"),
              Space().height(context,0.04),

            ]
          )),

          DrawerListTile(itemNumber: 1, onTap: () {  },),

        ]
      ),
    );
  }
}