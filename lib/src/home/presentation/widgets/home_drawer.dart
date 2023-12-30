// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_rental/assets/images/image_constants.dart';
import 'package:house_rental/assets/svgs/svg_constants.dart';

import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:house_rental/core/theme/colors.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/home/presentation/widgets/build_logout_bottomsheet.dart';
import 'package:house_rental/src/home/presentation/widgets/drawer_list_tile.dart';

class HomeDrawer extends StatefulWidget {
  final String? phoneNumber, profileUrl, id, uid, firstName, lastName, email;

  const HomeDrawer({
    Key? key,
    required this.phoneNumber,
    required this.profileUrl,
    required this.id,
    required this.uid,
    this.firstName,
    this.lastName,
    this.email,
  }) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final authBloc = locator<AuthenticationBloc>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          gradient: primaryGradient,
          color: blueOceanColor1,
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Space().height(context, 0.05),
        SizedBox(
          height: 70,
          width: 70,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: searchTextColor3,
                  backgroundImage: widget.profileUrl != null
                      ? Image.network(widget.profileUrl!).image
                      : Image.asset(user1Image, width: 100, height: 100).image,
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(editSVG))
            ],
          ),
        ),
        Space().height(context, 0.02),
        Text(
          "${widget.firstName} ${widget.lastName}",
          style: appTheme.textTheme.displayLarge!
              .copyWith(color: houseWhiteColor, fontWeight: FontWeight.w400),
        ),
        Space().height(context, 0.02),
        Text(
          widget.phoneNumber ?? "",
          style: appTheme.textTheme.displayLarge!
              .copyWith(color: houseWhiteColor, fontWeight: FontWeight.w400),
        ),
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
          onTap: () {},
        ),
        DrawerListTile(
          itemNumber: 4,
          onTap: () {},
        ),
        DrawerListTile(
          itemNumber: 5,
          onTap: () {},
        ),
        DrawerListTile(
          itemNumber: 6,
          onTap: () {},
        ),
        DrawerListTile(
          itemNumber: 7,
          onTap: () {},
        ),
        DrawerListTile(
          itemNumber: 8,
          onTap: () {
            buildLogoutBottomSheet(
              context,
              authBloc,
              widget.id ?? "",
              widget.uid ?? "",
              widget.phoneNumber ?? "",
              widget.firstName ?? "",
              widget.lastName ?? "",
              widget.email ?? "",
            );
          },
        ),
      ]),
    );
  }
}
