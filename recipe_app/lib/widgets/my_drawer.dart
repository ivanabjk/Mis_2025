import 'package:flutter/material.dart';
import 'package:recipe_app/screens/favorites_screen.dart';
import 'package:recipe_app/screens/profile_screen.dart';

import '../auth/auth_service.dart';
import 'drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final auth = AuthService();

  void logout() {
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              DrawerHeader(
                child: Icon(
                  Icons.set_meal,
                  size: 100,
                ),
              ),

              SizedBox(
                height: 25,
              ),

              // categories tile
              DrawerTile(
                title: "H O M E",
                leading: Icon(
                  Icons.home,
                ),
                onTap: () => Navigator.pop(context),
              ),

              // profile
              DrawerTile(
                title: "P R O F I L E",
                leading: Icon(
                  Icons.person,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),

              // favorites
              DrawerTile(
                title: "F A V O R I T E S",
                leading: Icon(
                  Icons.favorite,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoritesScreen()));
                },
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: DrawerTile(
              title: "L O G O U T",
              leading: Icon(
                Icons.logout,
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
