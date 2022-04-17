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
              title: Text(data.e!),
              background: const FlutterLogo(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Text(data.g!),
              Text(data.a!),
              Text(data.b!),
              Text(data.c!),
              Text(data.e!),
              Text(data.f!),
              Text(data.g!),
              Text(data.h!),
              (data.j != null && data.h != null)
                  ? ElevatedButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => GoogleMapPage(
                                    id: 'id',
                                    latitude: double.parse(data.j!),
                                    longitude: double.parse(data.h!),
                                  )),
                            ),
                          ),
                      child: const Text('Google Map'))
                  : Container()
            ]),
          )
        ],
      ),
    );
  }
}
