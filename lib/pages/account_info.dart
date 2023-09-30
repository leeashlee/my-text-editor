// ignore_for_file: library_private_types_in_public_api, always_declare_return_types

import 'package:flutter/material.dart';
import 'package:noel_notes/AppWrite/auth_api.dart';
import 'package:noel_notes/component/icons/unicon_icons.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String? email;
  late String? username;
  TextEditingController bioTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final AuthAPI appwrite = context.read<AuthAPI>();
    email = appwrite.email;
    username = appwrite.username;
    appwrite.getUserPreferences().then((value) {
      if (value.data.isNotEmpty) {
        setState(() {
          bioTextController.text = value.data['bio'];
        });
      }
    });
  }

  //FIXME Names to be synced inside Flutter
  saveName() {
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.updateName(name: usernameTextController.text);
    const snackbar = SnackBar(content: Text('Name updated!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  saveEmail() {
    if (emailTextController.text == "" || passwordTextController.text == "") {
      const snackbar = SnackBar(
          content: Text('Email wasn`t saved, Email or password is empty.'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return null;
    }
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.updateEmail(
        email: emailTextController.text, password: passwordTextController.text);
    const snackbar = SnackBar(content: Text('Email updated!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  savePassword() {
    if (passwordTextController.text == "") {
      const snackbar =
          SnackBar(content: Text('Password wasn`t saved because it`s empty.'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return null;
    }
    final AuthAPI appwrite = context.read<AuthAPI>();
    appwrite.updatePassword(password: passwordTextController.text);
    const snackbar = SnackBar(content: Text('Password updated!'));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Edit Username?'),
                            content: TextField(
                              controller: usernameTextController,
                              decoration: const InputDecoration(
                                labelText: 'Change Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  usernameTextController.clear();
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  saveName();
                                  usernameTextController.clear();
                                  Navigator.pop(context, 'Save');
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ),
                        icon: const Icon(Unicon.edit),
                      ),
                    ],
                  ),
                  MenuItemButton(
                    child: const Text("Change Email"),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        scrollable: true,
                        title: const Text('Change Email?'),
                        content: Column(
                          children: [
                            TextField(
                              controller: emailTextController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: passwordTextController,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              emailTextController.clear();
                              passwordTextController.clear();
                              Navigator.pop(context, 'Cancel');
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              saveEmail();
                              emailTextController.clear();
                              passwordTextController.clear();
                              Navigator.pop(context, 'Save');
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MenuItemButton(
                    child: const Text("Change Password"),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Change Password?'),
                        content: TextField(
                          controller: passwordTextController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              passwordTextController.clear();
                              Navigator.pop(context, 'Cancel');
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              savePassword();
                              passwordTextController.clear();
                              Navigator.pop(context, 'Save');
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
