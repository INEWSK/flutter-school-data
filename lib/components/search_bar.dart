import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../models/school.dart';
import '../pages/detail_page.dart';
import '../pages/google_map_page.dart';
import '../provider/intl_provider.dart';

class SearchBar extends SearchDelegate {
  SearchBar({required this.data});

  final List<School> data;

  List<School> results = [];

  Future<void> _alertDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(children: [
              const Icon(Icons.warning),
              const SizedBox(width: 10),
              Text(S.of(context).warning),
            ]),
            content: Text(
              S.of(context).openGoogleMap(results.length),
              style: const TextStyle(height: 1.5),
            ),
            actions: [
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(S.of(context).cancel),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Text(S.of(context).confirm),
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        GoogleMapPage(school: School(), data: results)),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      results.isNotEmpty
          ? IconButton(
              onPressed: () => results.length >= 50
                  ? _alertDialog(context)
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) =>
                            GoogleMapPage(school: School(), data: results)),
                      )),
              icon: const Icon(Icons.map))
          : const SizedBox(),
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
        onPressed: () => query = '',
      ),
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
    // * remove first item
    data.removeAt(0);

    results = data.where((source) {
      final input = query.toLowerCase();
      // * eng school name
      final engName = source.d.toString().toLowerCase();
      // * eng school address
      final engLocation = source.f.toString().toLowerCase();
      // * chi school name
      final chiName = source.e.toString();
      // * chi school address
      final chiLocation = source.g.toString();

      // * return search result
      return engName.contains(input) ||
          engLocation.contains(input) ||
          chiName.contains(input) ||
          chiLocation.contains(input);
    }).toList();

    if (query.isEmpty) {
      results.clear();
    }

    final Widget widget;
    final Locale locale = context.read<IntlProvider>().locale;

    results.isNotEmpty
        ? widget = ListView.builder(
            shrinkWrap: true,
            itemCount: results.length,
            itemBuilder: (context, index) {
              // * result list view
              return Column(
                children: [
                  ListTile(
                    title: locale == const Locale('zh', 'HK')
                        ? Text(results[index].e!)
                        : Text(results[index].d!),
                    subtitle: locale == const Locale('zh', 'HK')
                        ? Text(results[index].g!)
                        : Text(results[index].f!),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          data: results[index],
                        ),
                      ),
                    ),
                  ),
                  index != results.length - 1
                      ? const Divider()
                      : const SizedBox(),
                ],
              );
            },
          )
        // * no result view
        : (query.isNotEmpty && results.isEmpty)
            ? widget = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).nothingHere),
                  const SizedBox(height: 50),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: SvgPicture.asset('assets/svg/undraw_void.svg'),
                  ),
                ],
              )
            // * waiting user enter query view
            : widget = Center(
                child: Text(S.of(context).searchListed),
              );
    return widget;
  }
}
