import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_school_information/models/school.dart';
import 'package:flutter_school_information/pages/detail_page.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// * method of fetch data from url
Future _fetchData() async {
  var connect = await (Connectivity().checkConnectivity());

  if (connect == ConnectivityResult.none) {
    return Future.error("Network unavailable");
  }

  const path = 'assets/json/SCH_LOC_EDB.json';
  const url =
      'https://www.edb.gov.hk/attachment/en/student-parents/sch-info/sch-search/sch-location-info/SCH_LOC_EDB.json';

  try {
    final String response = await rootBundle.loadString(path);
    final data = List<School>.from(
      json.decode(response).map((i) => School.fromMap(i)),
    );
    return data;
  } catch (e) {
    return Future.error("Unable to fetch API");
  }
}

// ! override wantKeepAlive manually to keep page state
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  Widget _listView() {
    return FutureBuilder(
      future: _fetchData(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {}
          final data = snapshot.data as List<School>;
          // * building list view
          return ListView.builder(
            itemCount: data.length - 1, // skip first key
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(data[index + 1].e ?? '標題'),
                subtitle: Text(data[index + 1].g ?? '副標題'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      data: data[index + 1],
                    ),
                  ),
                ),
              );
            }),
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
                  // * reload whole list view widget (bad )
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
