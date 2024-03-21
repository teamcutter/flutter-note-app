import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/components/drawer_tile.dart';
import 'package:notes/pages/settings_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
              'Menu',
                style: GoogleFonts.archivo(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            )
          ),
          DrawerTile(
            title: 'Notes', 
            leading: const Icon(Icons.home), 
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Settings', 
            leading: const Icon(Icons.settings), 
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const SettingsPage(),
                )
              );
            },
          )
        ],
      ),
    );
  }
}