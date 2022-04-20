import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_school_information/common/utils/hive_utils.dart';
import 'package:flutter_school_information/models/school.dart';
import 'package:flutter_school_information/pages/detail_page.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../generated/l10n.dart';
import '../provider/intl_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// ! override wantKeepAlive manually to keep page state
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  // * method of fetch data from url
  Future _fetchData() async {
    const path = 'assets/json/SCH_LOC_EDB.json';
    const url =
        'https://www.edb.gov.hk/attachment/en/student-parents/sch-info/sch-search/sch-location-info/SCH_LOC_EDB.json';
    const String boxName = 'school_data';
    // * init hive utils
    var hiveUtils = HiveUtils();
    // * check connect status
    var connect = await (Connectivity().checkConnectivity());

    // * if no network, try get data from local database if exists
    if (connect == ConnectivityResult.none) {
      try {
        log('check is data exist in local');
        bool exist = await hiveUtils.isExists(boxName: boxName);
        if (exist) {
          log('data is exist, loading data from local database');
          List list = await hiveUtils.getBoxes<School>(boxName);
          // * remove first item
          list.removeAt(0);
          return list;
        }
      } catch (e) {
        // * no local data and no network, return error
        return Future.error('Network unavailable, please check your network');
      }
    }

    // * fetch data from API
    try {
      log('loading data from API');
      var response = await rootBundle.loadString(path);
      // var response = await Dio().get(
      //   url,
      //   options: Options(
      //     contentType: Headers.textPlainContentType,
      //     responseType: ResponseType.plain,
      //   ),
      // );

      final data = List<School>.from(
        json.decode(response).map((i) => School.fromMap(i)),
      );

      var box = await Hive.openBox(boxName);
      // * clear exist data
      await box.clear();
      // * store new data into box (database);
      await HiveUtils().addBoxes(data, boxName);
      // * pickup data from box
      List list = await HiveUtils().getBoxes<School>(boxName);
      // * remove first item
      list.removeAt(0);
      return list;
    } on DioError catch (e) {
      log(e.message);
      return Future.error("Unable to fetch API, check your network status");
    }
  }

  // * list view widget
  Widget _listView(BuildContext context) {
    final String language = context.read<IntlProvider>().language;
    return FutureBuilder(
      future: _fetchData(),
      builder: ((context, snapshot) {
        Widget child;
        if (snapshot.hasData) {
          final data = snapshot.data as List<School>;
          child = EasyRefresh(
            // * building list view
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: language == 'zh'
                      ? Text(data[index].e!)
                      : Text(data[index].d!),
                  subtitle: language == 'zh'
                      ? Text(data[index].g!)
                      : Text(data[index].f!),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        data: data[index],
                      ),
                    ),
                  ),
                  // dense: true,
                );
              }),
            ),
            // * pull to refresh
            onRefresh: () async {
              setState(() {});
            },
          );
        } else if (snapshot.hasError) {
          // * show error page and retry button
          final error = snapshot.error?.toString();
          child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(error ?? 'Error'),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // * reload whole list view widget
                    setState(() {
                      // ! setState will rebuild whole page
                      // ! also futureBuilder (list builder) and _fetchData method
                      // ! so no need call _fetchData method again here
                      // _listView(context);
                    });
                  },
                  label: const Text('Retry'),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          );
        } else {
          // * show loading effect
          child = _shimmer();
        }
        return child;
      }),
    );
  }

  // * loading effect
  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: (Colors.grey[300])!,
      highlightColor: (Colors.grey[100])!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: 40.0,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // * must call super in automaticKeepAliveClientMixin
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      body: _listView(context),
    );
  }
}
