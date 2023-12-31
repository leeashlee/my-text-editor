import 'package:flutter/material.dart';
import 'package:noel_notes/component/icons/unicon_icons.dart';
import 'package:noel_notes/pages/privacy_policy.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Unicon.arrow_left),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SafeArea(
              minimum: EdgeInsets.all(8),
              child: Text(
                textAlign: TextAlign.center,
                "Note Editor\nVersion 1.0.0",
              ),
            ),
            MenuItemButton(
              leadingIcon: const Icon(Unicon.link),
              child: const Text("Website"),
              onPressed: () async {
                final Uri url = Uri.parse('https://www.ashleehee.com/');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            MenuItemButton(
              leadingIcon: const Icon(Unicon.github_alt),
              child: const Text("Source Code"),
              onPressed: () async {
                final Uri url =
                    Uri.parse('https://github.com/leeashlee/my-text-editor');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            MenuItemButton(
              leadingIcon: const Icon(Unicon.coffee),
              child: const Text("Buy Me A Coffee"),
              onPressed: () async {
                final Uri url =
                    Uri.parse('https://www.buymeacoffee.com/ashleehee');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            MenuItemButton(
              leadingIcon: const Icon(Unicon.coffee),
              child: const Text("Privacy Policy"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicy(),
                  ),
                );
              },
            ),
            MenuItemButton(
              leadingIcon: const Icon(Unicon.clipboard_notes),
              child: const Text("License"),
              onPressed: () {
                showLicensePage(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
