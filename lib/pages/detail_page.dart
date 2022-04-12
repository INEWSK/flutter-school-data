import 'package:flutter/material.dart';
import 'package:flutter_school_information/models/school.dart';
import 'package:flutter_school_information/pages/google_map_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.data}) : super(key: key);

  final School data;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              title: Text(data.e ?? 'Title'),
              background: const FlutterLogo(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Text(data.g ?? '其他'),
              (data.j != null && data.h != null)
                  ? ElevatedButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => GoogleMapPage(
                                    id: 'id',
                                    latitude: double.parse(data.j ?? '1234'),
                                    longitude: double.parse(data.h ?? '234'),
                                  )),
                            ),
                          ),
                      child: const Text('Button'))
                  : Container()
            ]),
          )
        ],
      ),
    );
  }
}
