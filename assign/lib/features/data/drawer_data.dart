import 'package:assign/core/utils/components/custom_drawer.dart';
import 'package:flutter/material.dart';

List<CustomDrawerItem> actionsList= [
          CustomDrawerItem(
            icon: Icons.account_circle,
            title: 'Artists',
            onTap: () {
              // Navigator.pop(context);
              // Your navigation logic here
            },
          ),
          CustomDrawerItem(
            icon: Icons.album,
            title: 'Albums',
            onTap: () {
              // Navigator.pop(context);
              // Your navigation logic here
            },
          ),
          CustomDrawerItem(
            icon: Icons.favorite,
            title: 'Favourite',
            onTap: () {
              // Navigator.pop(context);
              // Your navigation logic here
            },
          ),
        ];