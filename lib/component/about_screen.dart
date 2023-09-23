import 'package:flutter/material.dart';
import 'package:noel_notes/unicon_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Container(padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SafeArea(
              minimum: EdgeInsets.all(8),
              child: Text(
                textAlign: TextAlign.center,
                "Note Editor\nVersion 1.0.0\nMade with love by AshLee!",
              ),
            ),
            MenuItemButton(
              leadingIcon: Icon(Unicon.link),
              child: Text("Website"),
              onPressed: () async {
                final Uri url = Uri.parse('https://www.ashleehee.com/');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            MenuItemButton(
              leadingIcon: Icon(Unicon.github_alt),
              child: Text("Source Code"),
              onPressed: () async {
                final Uri url = Uri.parse('https://github.com/leeashlee/my-text-editor');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
