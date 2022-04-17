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
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// * method of fetch data from url
Future _fetchData() async {
  const path = 'assets/json/SCH_LOC_EDB.json';
  const url =
      'https://www.edb.gov.hk/attachment/en/student-parents/sch-info/sch-search/sch-location-info/SCH_LOC_EDB.json';
  // * init hive utils
  var hiveUtils = HiveUtils();
  // * check connect status
  var connect = await (Connectivity().checkConnectivity());

  const String boxName = 'school_data';

  if (connect == ConnectivityResult.none) {
    try {
      // * if network unavailable, check for local data
      bool exist = await hiveUtils.isExists(boxName: boxName);
      if (exist) {
        List list = await hiveUtils.getBoxes<School>(boxName);
        return list;
      }
    } catch (e) {
      // * no local data, and no network
      return Future.error('Network unavailable, please check your network');
    }
  }

  try {
    var response = await rootBundle.loadString(path);

    final data = List<School>.from(
      json.decode(response).map((i) => School.fromMap(i)),
    );

    // * clear exist data
    var box = await Hive.openBox('school_data');
    await box.clear();
    // * store new data into box (database);
    await HiveUtils().addBoxes(data, 'school_data');
    // * pickup data from box
    List list = await HiveUtils().getBoxes<School>('school_data');
    // * remove first item
    list.removeAt(0);
    return list;
  } catch (e) {
    log(e.toString());
    return Future.error("Unable to fetch API");
  }
}

// ! override wantKeepAlive manually to keep page state
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  // * list view widget
  Widget _listView() {
    return FutureBuilder(
      future: _fetchData(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as List<School>;
          return EasyRefresh(
            // * building list view
            child: ListView.builder(
              itemCount: data.length, // skip first key
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(data[index].e!),
                  subtitle: Text(data[index].g!),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        data: data[index],
                      ),
                    ),
                  ),
                );
              }),
            ),
            // * pull to refresh and fetch API again
            onRefresh: () async {
              setState(() {
                _fetchData();
              });
            },
          );
        } else if (snapshot.hasError) {
          // * show error page and retry button
          final error = snapshot.error?.toString();
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error ?? 'Error'),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // * reload whole list view widget
                  setState(() {
                    _listView();
                  });
                },
                label: const Text('Retry'),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ));
        } else {
          // * show loading effect
          return _shimmer();
        }
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
      body: _listView(),
    );
  }
}
