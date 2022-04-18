import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/school.dart';
import 'google_map_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.data}) : super(key: key);

  final School data;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> _launchURL({required String type, required String url}) async {
    String title;
    String message;
    String scheme;
    if (type == 'http') {
      title = 'Open website';
      message = 'Press YES to launch browser.';
      scheme = '';
    } else {
      title = 'Phone call';
      message = 'Press YES to make phone call.';
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Text('Yes'),
              ),
              onPressed: () => Navigator.pop(
                context,
                launch(scheme + url),
              ),
            ),
            TextButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Text('Cancel'),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text(data.e!),
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
                      id: data.a!,
                      latitude: double.parse(data.j!),
                      longitude: double.parse(data.h!),
                      school: data.e!,
                      address: data.g!,
                    )),
              ),
            ),
            icon: const Icon(Icons.map),
            label: const Text('地圖上顯示'),
          )
        : const SizedBox();
  }

  Widget _schoolName(School data) {
    return ContentBlock(
      icon: const Icon(Icons.school),
      title: '學校名稱',
      children: [
        Text(data.e!),
      ],
    );
  }

  Widget _schoolType(School data) {
    return ContentBlock(
      icon: const Icon(Icons.class_),
      title: '學校類型',
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(6),
          },
          children: [
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('學校類別'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(data.y!),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('資助種類'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(data.w!),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('就讀學生性別'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(data.q!),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('授課時間'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(data.s!),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('宗教信仰'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(data.ag!),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _schoolAddress(School data) {
    return ContentBlock(
      icon: const Icon(Icons.location_city),
      title: '學校地址',
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(7),
          },
          children: [
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('分區'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(data.u!),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('地址'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(data.g!),
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
      title: '聯絡資料',
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(6),
          },
          children: [
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('聯絡電話'),
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
                          onTap: () => _launchURL(type: 'tel', url: data.aa!),
                        )
                      : const Text('沒有提供')),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('傳真號碼'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: (data.aa!.isNotEmpty && !data.aa!.contains('N.A.')
                      ? Text(data.ac!)
                      : const Text('沒有提供')),
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
      title: '學校網頁',
      children: [
        (data.ae!.isEmpty || data.ae!.contains('N.A'))
            ? Text('沒有提供')
            : GestureDetector(
                child: Text(
                  data.ae!,
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => _launchURL(type: 'http', url: data.ae!),
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
