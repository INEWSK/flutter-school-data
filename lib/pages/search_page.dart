import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/utils/hive_utils.dart';
import '../common/utils/toast_utils.dart';
import '../components/search_bar.dart';
import '../generated/l10n.dart';
import '../models/school.dart';
import 'filter_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;

  // * get data from box (local database)
  Future<List<School>> _getData() async {
    var hiveUtils = HiveUtils();
    // * for demo to display loading animation
    // TODO remove it before release apk
    // await Future.delayed(const Duration(seconds: 3));

    try {
      List<School> data = await hiveUtils.getBoxes<School>('school_data');
      return data;
    } catch (e) {
      log(e.toString());
      return Future.error("Unable to get data from Hive");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        Widget widget;
        if (snapshot.hasData) {
          final data = snapshot.data as List<School>;
          widget = _searchBody(data);
        } else if (snapshot.hasError) {
          widget = _errorPage();
          Toast.show(snapshot.data.toString());
        } else {
          widget = _loading();
        }
        return widget;
      },
    );
  }

  Widget _loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpinKitChasingDots(color: Colors.blueAccent),
        const SizedBox(height: 50),
        Text(S.of(context).loading),
      ],
    );
  }

  Widget _errorPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(S.of(context).clickToRetry),
        const SizedBox(height: 50),
        AspectRatio(
            aspectRatio: 1.5,
            child: SvgPicture.asset('assets/svg/undraw_404.svg')),
        const SizedBox(height: 50),
        ElevatedButton.icon(
          onPressed: () => setState(() {
            _getData();
          }),
          icon: const Icon(Icons.refresh),
          label: Text(S.of(context).retry),
        ),
      ],
    );
  }

  Widget _searchBody(List<School> data) {
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                S.of(context).sortBy,
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: _categoryCard(
                  title: S.of(context).primarySchool,
                  query: "PRIMARY",
                  data: data,
                ),
              ),
              Expanded(
                child: _categoryCard(
                  title: S.of(context).secondarySchool,
                  query: "SECONDARY",
                  data: data,
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).clickToSearch),
                  const SizedBox(height: 50),
                  AspectRatio(
                      aspectRatio: 1.5,
                      child: SvgPicture.asset(
                          'assets/svg/undraw_location_search.svg')),
                  const SizedBox(height: 50),
                  ElevatedButton.icon(
                    onPressed: () => showSearch(
                      context: context,
                      delegate: SearchBar(data: data),
                    ),
                    icon: const Icon(Icons.search),
                    label: Text(S.of(context).search),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryCard({
    required String title,
    required String query,
    required List<School> data,
  }) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            // leading: const Icon(Icons.search),
            // trailing: const Icon(Icons.arrow_right),
            title: Text(
              title,
              style: const TextStyle(fontSize: 14.0),
            ),
            // trailing: const Icon(Icons.arrow_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => FilterPage(
                    title: title,
                    data: data
                        .where((element) => element.x!.contains(query))
                        .toList())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
