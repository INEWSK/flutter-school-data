import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(title: Text('Theme'), subtitle: Text('Light')),
        ListTile(title: Text('Language'), subtitle: Text("Chinese")),
        ListTile(title: Text('Terms')),
        ListTile(title: Text('About')),
      ],
    );
  }
}
