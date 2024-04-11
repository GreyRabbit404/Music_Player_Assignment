import 'package:assign/core/constants/colros.dart';
import 'package:flutter/material.dart';

class CustomDrawerItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  CustomDrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

class CustomDrawer extends StatelessWidget {
  final String drawerTitle;
  final List<CustomDrawerItem> items;

  const CustomDrawer({
    Key? key,
    required this.drawerTitle,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: AppColors.bgColor,
      elevation: 5,
      surfaceTintColor: AppColors.textColor,
      child: ListView(
        children: [
          DrawerHeader(
            curve: Curves.bounceInOut,
            margin:
                EdgeInsetsGeometry.lerp(EdgeInsets.zero, EdgeInsets.zero, 0.6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              drawerTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          for (var item in items)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
