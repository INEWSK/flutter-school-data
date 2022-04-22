import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/l10n.dart';
import '../models/school.dart';
import '../provider/intl_provider.dart';
import 'google_map_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.data}) : super(key: key);

  final School data;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> _launchURLDialog(
      {required String type, required String url}) async {
    String title;
    String message;
    String scheme;
    if (type == 'http') {
      title = S.of(context).openWeb;
      message = S.of(context).clickToBrowse;
      scheme = '';
    } else {
      title = S.of(context).phoneCall;
      message = S.of(context).clickToCall;
      scheme = 'tel://';
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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
              onPressed: () => Navigator.pop(
                context,
                launch(scheme + url),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Locale locale = context.read<IntlProvider>().locale;
    final data = widget.data;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              title: locale == const Locale('zh', 'HK')
                  ? Text(data.e!)
                  : Text(data.d!),
              background: const FlutterLogo(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _schoolName(data),
                  _schoolType(data),
                  _schoolAddress(data),
                  _schoolContact(data),
                  _schoolWebsite(data),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _googleMapButton(School data) {
    return (data.j != null && data.h != null)
        ? ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => GoogleMapPage(
                      school: data,
                      data: const [],
                    )),
              ),
            ),
            icon: const Icon(Icons.map),
            label: Text(S.of(context).showOnMap),
          )
        : const SizedBox();
  }

  Widget _schoolName(School data) {
    return ContentBlock(
      icon: const Icon(Icons.school),
      title: S.of(context).schoolName,
      children: [
        Text(data.e!),
        const SizedBox(height: 10),
        Text(data.d!),
      ],
    );
  }

  Widget _schoolType(School data) {
    final Locale locale = context.read<IntlProvider>().locale;

    return ContentBlock(
      icon: const Icon(Icons.class_),
      title: S.of(context).schoolType,
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(6),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).schoolLevel),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: locale == const Locale('zh', 'HK')
                      ? Text(data.y!)
                      : Text(data.x!),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).financeType),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: locale == const Locale('zh', 'HK')
                      ? Text(data.w!)
                      : Text(data.v!),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).studentGender),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: locale == const Locale('zh', 'HK')
                      ? Text(data.q!)
                      : Text(data.p!),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).schoolSession),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: locale == const Locale('zh', 'HK')
                      ? Text(data.s!)
                      : Text(data.r!),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).religion),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: locale == const Locale('zh', 'HK')
                      ? Text(data.ag!)
                      : Text(data.af!),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _schoolAddress(School data) {
    final Locale locale = context.read<IntlProvider>().locale;

    return ContentBlock(
      icon: const Icon(Icons.location_city),
      title: S.of(context).schoolType,
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(7),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).district),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: locale == const Locale('zh', 'HK')
                      ? Text(data.u!)
                      : Text(data.t!),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).address),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: locale == const Locale('zh', 'HK')
                      ? Text(data.g!)
                      : Text(data.f!),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _googleMapButton(data),
        )
      ],
    );
  }

  Widget _schoolContact(School data) {
    return ContentBlock(
      icon: const Icon(Icons.contact_mail),
      title: S.of(context).contact,
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(6),
          },
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).telephone),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: (data.aa!.isNotEmpty && !data.aa!.contains('N.A.')
                      ? GestureDetector(
                          child: Text(
                            data.aa!,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () =>
                              _launchURLDialog(type: 'tel', url: data.aa!),
                        )
                      : Text(S.of(context).NA)),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(S.of(context).faxNumber),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: (data.aa!.isNotEmpty && !data.aa!.contains('N.A.')
                      ? Text(data.ac!)
                      : Text(S.of(context).NA)),
                ),
              ],
            ),
          ],
        ),
        Container(),
      ],
    );
  }

  Widget _schoolWebsite(School data) {
    return ContentBlock(
      icon: const Icon(Icons.web),
      title: S.of(context).website,
      children: [
        (data.ae!.isEmpty || data.ae!.contains('N.A'))
            ? Text(S.of(context).NA)
            : GestureDetector(
                child: Text(
                  data.ae!,
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => _launchURLDialog(type: 'http', url: data.ae!),
              ),
      ],
    );
  }
}

class ContentBlock extends StatelessWidget {
  const ContentBlock(
      {Key? key,
      required this.icon,
      required this.title,
      required this.children})
      : super(key: key);

  final String title;
  final Icon icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: icon,
                ),
              ),
              TextSpan(
                text: title,
                style: const TextStyle(fontSize: 16.0),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Divider(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
