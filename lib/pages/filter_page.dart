import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../components/search_bar.dart';
import '../generated/l10n.dart';
import '../models/school.dart';
import '../provider/intl_provider.dart';
import 'detail_page.dart';
import 'google_map_page.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  final List<School> data;
  final String title;

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
              S.of(context).openGoogleMap(data.length),
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
                        GoogleMapPage(school: School(), data: data)),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Locale locale = context.read<IntlProvider>().locale;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => data.length > 50
                // * if more than 50 school data display in google, shows warning
                ? _alertDialog(context)
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) =>
                          GoogleMapPage(school: School(), data: data)),
                    ),
                  ),
            icon: const Icon(
              Icons.map_outlined,
            ),
          )
        ],
      ),
      // * school list view
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: ((context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Column(
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
                      index != data.length - 1
                          ? const Divider()
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      // * search button
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSearch(
          context: context,
          delegate: SearchBar(data: data),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }
}
