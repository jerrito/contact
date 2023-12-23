import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final int itemNumber;
  final void Function() onTap;
  const DrawerListTile({
    super.key,
    required this.itemNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(itemNumber == 1
          ? "Profile Settings"
          : itemNumber == 2
              ? "Settings Page"
              : itemNumber == 3
                  ? "About Us"
                  : "Log out"),
    );
  }
}
