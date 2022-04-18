import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_school_information/common/utils/toast_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/utils/hive_utils.dart';
import '../models/school.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;

  List<School> _source = [];

  // * get data from box (local database)
  Future _getData() async {
    var hiveUtils = HiveUtils();
    try {
      List<School> data = await hiveUtils.getBoxes<School>('school_data');
      if (data.isNotEmpty) {
        _source = data;
        return true;
      }
      return Future.error('Data is empty');
    } catch (e) {
      log(e.toString());
      return Future.error("Unable to get data from Hive");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _pageContent(),
    );
  }

  FutureBuilder<dynamic> _pageContent() {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = [
            const Text('Press button to search school information.'),
            const SizedBox(height: 50),
            AspectRatio(
                aspectRatio: 1.5,
                child: SvgPicture.asset('assets/svg/undraw_searching.svg')),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () => showSearch(
                context: context,
                delegate: SearchBar(_source),
              ),
              icon: const Icon(Icons.search),
              label: const Text('Search'),
            ),
          ];
        } else if (snapshot.hasError) {
          children = [
            const Text('Press button try to refresh data.'),
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
              label: const Text('Retry'),
            ),
          ];
          Toast.show(snapshot.data.toString());
        } else {
          children = [
            const Center(
              child: SpinKitFadingCube(color: Colors.blueAccent),
            )
          ];
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}

class SearchBar extends SearchDelegate {
  final List<School> source;

  SearchBar(this.source);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ""),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, // animate back icon effect
        progress: transitionAnimation,
      ),
      onPressed: () {
        // close context when clicked
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<School> suggestions = source.where((source) {
      final searchNameResult = source.d.toString().toLowerCase();
      final locationResult = source.f.toString().toLowerCase();
      final input = query.toLowerCase();

      return searchNameResult.contains(input) || locationResult.contains(input);
    }).toList();

    if (query.isEmpty) {
      suggestions.clear();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: Text(suggestions[index].d!),
            subtitle: Text(suggestions[index].f!),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  data: suggestions[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
