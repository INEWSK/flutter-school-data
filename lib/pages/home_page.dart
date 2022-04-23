import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../common/utils/hive_utils.dart';
import '../generated/l10n.dart';
import '../models/school.dart';
import '../provider/intl_provider.dart';
import 'detail_page.dart';

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

  Future<List<School>> _fetchLocalData() async {
    var hiveUtils = HiveUtils();
    const String boxName = 'school_data';

    log('try to loading data from local database');
    bool exist = await hiveUtils.isExists(boxName: boxName);

    if (exist) {
      List<School> list = await hiveUtils.getBoxes<School>(boxName);
      // * remove first item
      list.removeAt(0);
      return list;
    } else {
      return Future.error('No data in local');
    }
  }

  Future<List<School>> _fetchAPIData() async {
    const path = 'assets/json/SCH_LOC_EDB.json';
    const url =
        'https://www.edb.gov.hk/attachment/en/student-parents/sch-info/sch-search/sch-location-info/SCH_LOC_EDB.json';
    const String boxName = 'school_data';
    // * init hive utils
    var hiveUtils = HiveUtils();

    try {
      log('loading data from API');
      // var response = await rootBundle.loadString(path);
      var response = await Dio().get(
        url,
        options: Options(
          contentType: Headers.textPlainContentType,
          responseType: ResponseType.plain,
        ),
      );

      final data = List<School>.from(
        json.decode(response.data).map((i) => School.fromMap(i)),
      );

      var box = await Hive.openBox(boxName);
      // * clear exist data
      await box.clear();
      // * store new data into box (database);
      await hiveUtils.addBoxes(data, boxName);
      // * pickup data from box
      List<School> list = await hiveUtils.getBoxes<School>(boxName);
      // * remove first item
      list.removeAt(0);
      return list;
    } on DioError catch (e) {
      log(e.message);
      return Future.error("Unable to fetch API, check your network status");
    }
  }

  // * method of fetch data
  Future<List<School>> _fetchData() async {
    // * for demo to display loading animation
    // TODO remove it before build app
    // await Future.delayed(const Duration(seconds: 3));

    // * check connect status
    var connect = await (Connectivity().checkConnectivity());
    // * if no network, try get data from local database
    return connect == ConnectivityResult.none
        ? _fetchLocalData()
        : _fetchAPIData();
  }

  // * build home page body
  Widget _body(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: ((context, snapshot) {
        Widget child;
        if (snapshot.hasData) {
          final data = snapshot.data as List<School>;
          child = _listView(data);
        } else if (snapshot.hasError) {
          // * show error page with retry button
          child = _errorPage();
        } else {
          // * show loading effect
          child = _loadingIndicator();
        }
        return child;
      }),
    );
  }

  Widget _errorPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.of(context).clickToRetry),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              // * reload whole list view widget
              setState(() {
                // ! setState will rebuild whole page
                // ! also futureBuilder (list builder) and _fetchData method
                // ! so no need call _fetchData method and rebuild listView again here
                // _listView(context);
              });
            },
            label: Text(S.of(context).retry),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  // * school list view
  Widget _listView(List<School> data) {
    return EasyRefresh.custom(
      // * building list view
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(((context, index) {
            return _listItem(data, index);
          }), childCount: data.length),
        )
      ],
      header: DeliveryHeader(),
      // * pull to refresh
      onRefresh: () async {
        setState(() {});
      },
    );
  }

  Widget _listItem(List<School> data, int index) {
    final Locale locale = context.read<IntlProvider>().locale;
    return Column(
      children: [
        ListTile(
          title: locale == const Locale('zh', 'HK')
              ? Text(data[index].e!)
              : Text(data[index].d!),
          subtitle: locale == const Locale('zh', 'HK')
              ? Text(data[index].g!)
              : Text(data[index].f!),
          // trailing: const Icon(Icons.chevron_right),
          // dense: true,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                data: data[index],
              ),
            ),
          ),
        ),
        index != data.length - 1 ? const Divider() : const SizedBox(),
      ],
    );
  }

  // * loading effect
  Widget _loadingIndicator() {
    final brightness = Theme.of(context).brightness;
    // * shimmer effect no look good in dark mode
    if (brightness == Brightness.dark) {
      return const SpinKitFadingCube(color: Colors.blueAccent);
    } else {
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
  }

  @override
  Widget build(BuildContext context) {
    // * must call super in automaticKeepAliveClientMixin
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      body: _body(context),
    );
  }
}
