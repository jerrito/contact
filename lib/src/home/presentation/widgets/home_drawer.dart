// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';

import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/build_logout_bottomsheet.dart';
import 'package:house_rental/src/home/presentation/widgets/drawer_list_tile.dart';

class HomeDrawer extends StatefulWidget {
  final String? fullName, phoneNumber, profileUrl, id, uid;

  const HomeDrawer(
      {Key? key,
      required this.fullName,
      required this.phoneNumber,
      required this.profileUrl,
      required this.id,
      required this.uid})
      : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final authBloc = locator<AuthenticationBloc>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        SizedBox(
          height: 100,
          width: 100,
          child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: widget.profileUrl != null
                          ? Image.network(widget.profileUrl!).image
                          : Image.asset(user1Image, width: 100, height: 100)
                              .image)),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(editSVG))),
        ),
        Space().height(context, 0.02),
        Text(widget.fullName ?? ""),
        Space().height(context, 0.02),
        Text(widget.phoneNumber ?? ""),
        Space().height(context, 0.04),
        DrawerListTile(
          itemNumber: 1,
          onTap: () {},
        ),
        DrawerListTile(
          itemNumber: 2,
          onTap: () {},
        ),
        DrawerListTile(
          itemNumber: 3,
          onTap: () {
            
          },
        ),
        DrawerListTile(
          itemNumber: 4,
          onTap: () {
            
            buildLogoutBottomSheet(
              context,
              authBloc,
              widget.id ?? "",
              widget.uid ?? "",
              widget.phoneNumber ?? "",
            );
          },
        ),
      ]),
    );
  }
}
