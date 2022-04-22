import 'package:flutter/material.dart';
import 'package:flutter_school_information/pages/agreement_page.dart';
import 'package:flutter_school_information/provider/intl_provider.dart';
import 'package:flutter_school_information/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

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
          title: Text(S.of(context).themeDialogTitle),
          children: [
            _dialogOption(context, 0, S.of(context).followSystem),
            _dialogOption(context, 1, S.of(context).lightTheme),
            _dialogOption(context, 2, S.of(context).darkTheme),
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
          title: Text(S.of(context).languageDialogTitle),
          children: [
            _dialogOption(context, 0, S.of(context).followSystem),
            _dialogOption(context, 1, S.of(context).chinese),
            _dialogOption(context, 2, S.of(context).english),
          ],
        );
      },
    );
    if (!i.isNaN) {
      final String language;
      i == 0
          ? language = 'default'
          : i == 1
              ? language = 'zh'
              : language = 'en';
      context.read<IntlProvider>().setLocale(language: language);
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
    final ThemeMode themeMode = context.read<ThemeProvider>().theme;
    final String text;

    switch (themeMode) {
      case ThemeMode.light:
        text = S.of(context).lightTheme;
        break;
      case ThemeMode.dark:
        text = S.of(context).darkTheme;
        break;
      default:
        text = S.of(context).followSystem;
    }
    return text;
  }

  String _getLocale(BuildContext context) {
    final Locale locale = context.read<IntlProvider>().locale;
    final String text;

    if (locale == const Locale('zh', 'HK')) {
      text = S.of(context).chinese;
    } else if (locale == const Locale('en')) {
      text = S.of(context).english;
    } else {
      text = S.of(context).followSystem;
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer2(
      builder: (_, ThemeProvider provider, IntlProvider intl, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  S.of(context).settings,
                  style: const TextStyle(fontSize: 48.0),
                ),
              ),
            ),
            // * column inside a column and make it scrollable
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(S.of(context).theme),
                      subtitle: Text(_getTheme(context)),
                      onTap: () => _selectTheme(context),
                    ),
                    ListTile(
                      title: Text(S.of(context).language),
                      subtitle: Text(_getLocale(context)),
                      onTap: () => _selectLanguage(context),
                    ),
                    ListTile(
                      title: Text(S.of(context).terms),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const AgreementPage()),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(S.of(context).about),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationLegalese:
                              'Copyright(c) 2022\nmade by HKMU students\nschool data from HK GOV',
                          applicationName: S.of(context).appTitle,
                          applicationVersion: '0.1a',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
