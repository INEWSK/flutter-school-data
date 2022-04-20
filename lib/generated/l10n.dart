// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `HK School Information`
  String get appTitle {
    return Intl.message(
      'HK School Information',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get terms {
    return Intl.message(
      'Terms',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Follow System`
  String get followSystem {
    return Intl.message(
      'Follow System',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Select theme`
  String get themeDialogTitle {
    return Intl.message(
      'Select theme',
      name: 'themeDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightTheme {
    return Intl.message(
      'Light Mode',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkTheme {
    return Intl.message(
      'Dark Mode',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get languageDialogTitle {
    return Intl.message(
      'Select language',
      name: 'languageDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get chinese {
    return Intl.message(
      'Chinese',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Show on Map`
  String get showOnMap {
    return Intl.message(
      'Show on Map',
      name: 'showOnMap',
      desc: '',
      args: [],
    );
  }

  /// `School Name`
  String get schoolName {
    return Intl.message(
      'School Name',
      name: 'schoolName',
      desc: '',
      args: [],
    );
  }

  /// `School Type`
  String get schoolType {
    return Intl.message(
      'School Type',
      name: 'schoolType',
      desc: '',
      args: [],
    );
  }

  /// `School Address`
  String get schoolAddr {
    return Intl.message(
      'School Address',
      name: 'schoolAddr',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Phone call`
  String get phoneCall {
    return Intl.message(
      'Phone call',
      name: 'phoneCall',
      desc: '',
      args: [],
    );
  }

  /// `Open website`
  String get openWeb {
    return Intl.message(
      'Open website',
      name: 'openWeb',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `School level`
  String get schoolLevel {
    return Intl.message(
      'School level',
      name: 'schoolLevel',
      desc: '',
      args: [],
    );
  }

  /// `Finance type`
  String get financeType {
    return Intl.message(
      'Finance type',
      name: 'financeType',
      desc: '',
      args: [],
    );
  }

  /// `Student gender`
  String get studentGender {
    return Intl.message(
      'Student gender',
      name: 'studentGender',
      desc: '',
      args: [],
    );
  }

  /// `Session`
  String get schoolSession {
    return Intl.message(
      'Session',
      name: 'schoolSession',
      desc: '',
      args: [],
    );
  }

  /// `Religion`
  String get religion {
    return Intl.message(
      'Religion',
      name: 'religion',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message(
      'District',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Telephone`
  String get telephone {
    return Intl.message(
      'Telephone',
      name: 'telephone',
      desc: '',
      args: [],
    );
  }

  /// `Fax number`
  String get faxNumber {
    return Intl.message(
      'Fax number',
      name: 'faxNumber',
      desc: '',
      args: [],
    );
  }

  /// `N.A.`
  String get NA {
    return Intl.message(
      'N.A.',
      name: 'NA',
      desc: '',
      args: [],
    );
  }

  /// `Press OK to call the phone number`
  String get clickToCall {
    return Intl.message(
      'Press OK to call the phone number',
      name: 'clickToCall',
      desc: '',
      args: [],
    );
  }

  /// `Press OK to browse school website`
  String get clickToBrowse {
    return Intl.message(
      'Press OK to browse school website',
      name: 'clickToBrowse',
      desc: '',
      args: [],
    );
  }

  /// `Press button to search school information`
  String get clickToSearch {
    return Intl.message(
      'Press button to search school information',
      name: 'clickToSearch',
      desc: '',
      args: [],
    );
  }

  /// `Press button try to refresh data`
  String get clickToRetry {
    return Intl.message(
      'Press button try to refresh data',
      name: 'clickToRetry',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
