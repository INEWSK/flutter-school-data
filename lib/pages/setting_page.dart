import 'package:flutter/material.dart';
import 'package:flutter_school_information/common/utils/toast_utils.dart';
import 'package:flutter_school_information/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with AutomaticKeepAliveClientMixin<SettingPage> {
  @override
  bool get wantKeepAlive => true;

  _selectTheme(BuildContext context) async {
    int i = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Theme Color'),
          children: [
            _dialogOption(context, 0, 'Follow System'),
            _dialogOption(context, 1, 'Light'),
            _dialogOption(context, 2, 'Dark'),
          ],
        );
      },
    );
    if (!i.isNaN) {
      final ThemeMode themeMode;
      i == 0
          ? themeMode = ThemeMode.system
          : i == 1
              ? themeMode = ThemeMode.light
              : themeMode = ThemeMode.dark;
      context.read<ThemeProvider>().setTheme(themeMode);
    }
  }

  _selectLanguage(BuildContext context) async {
    int i = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Language'),
          children: [
            _dialogOption(context, 0, 'Default'),
            _dialogOption(context, 1, 'Chinese'),
            _dialogOption(context, 2, 'English'),
          ],
        );
      },
    );
    if (!i.isNaN) {
      String message;
      i == 0
          ? message = 'Default'
          : i == 1
              ? message = 'Chinese'
              : message = 'English';
      Toast.show(message);
    }
  }

  Widget _dialogOption(BuildContext context, int i, String title) {
    return SimpleDialogOption(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Text(title),
      ),
      onPressed: () => Navigator.pop(context, i),
    );
  }

  String _getTheme(BuildContext context) {
    final ThemeMode themeMode = context.read<ThemeProvider>().getTheme();
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'Follow System';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ThemeProvider>(
      builder: (_, provider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 48.0),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Theme'),
                    subtitle: Text(_getTheme(context)),
                    onTap: () => _selectTheme(context),
                  ),
                  ListTile(
                    title: const Text('Language'),
                    subtitle: const Text("Chinese"),
                    onTap: () => _selectLanguage(context),
                  ),
                  ListTile(
                    title: const Text('Terms'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('About'),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationLegalese:
                            'Copyright(c) 2022 by hkmu.comps313f student',
                        applicationName: 'Hong Kong School Information',
                        applicationVersion: '0.1',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
