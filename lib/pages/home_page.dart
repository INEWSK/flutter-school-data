import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school_information/demo/demo_data.dart';
import 'package:flutter_school_information/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Future fetchApi() async {
  const url =
      'https://www.edb.gov.hk/attachment/en/student-parents/sch-info/sch-search/sch-location-info/SCH_LOC_EDB.json';
  try {
    final response = await Dio().get(url);

    return response.data;
  } catch (e) {
    log('Catch: ' + e.toString());
    return null;
  }
}

class _HomePageState extends State<HomePage> {
  Widget listView() {
    return ListView.builder(
      itemCount: demoSchoolInfoData.length - 1, // skip first key
      itemBuilder: ((context, index) {
        return ListTile(
          title: Text(demoSchoolInfoData[index + 1]["E"]),
          subtitle: Text(demoSchoolInfoData[index + 1]["G"]),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                data: demoSchoolInfoData[index + 1],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return listView();
  }
}
