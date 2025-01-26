import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:larva_detector_app/helpers/confirm_dialog.dart';
// import 'package:larva_detector_app/helpers/display_message.dart';

class MyDeawer extends StatelessWidget {
  const MyDeawer({super.key});

  void exitFunction(){
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //DrawerHeader
          const DrawerHeader(child: Icon(Icons.bug_report)),

          //home
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          //exit app
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("E X I T"),
              onTap: () {
                // ConfirmDialog("Do you want to exit?",context,exitFunction);
              },
            ),
          )
        ],
      ),
    );
  }
}
