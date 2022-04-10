import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, this.data}) : super(key: key);

  final data;

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
              title: Text(data["E"]),
              background: const FlutterLogo(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(data["A"], style: TextStyle(fontSize: 30)),
                Text(data["B"], style: TextStyle(fontSize: 30)),
                Text(data["C"], style: TextStyle(fontSize: 30)),
                Text(data["D"], style: TextStyle(fontSize: 30)),
                Text(data["E"], style: TextStyle(fontSize: 30)),
                Text(data["F"], style: TextStyle(fontSize: 30)),
                Text(data["G"], style: TextStyle(fontSize: 30)),
                Text(data["H"], style: TextStyle(fontSize: 30)),
                Text(data["I"], style: TextStyle(fontSize: 30)),
                Text(data["J"], style: TextStyle(fontSize: 30)),
                Text(data["K"], style: TextStyle(fontSize: 30)),
                Text(data["L"], style: TextStyle(fontSize: 30)),
                Text(data["M"], style: TextStyle(fontSize: 30)),
                Text(data["N"], style: TextStyle(fontSize: 30)),
                Text(data["O"], style: TextStyle(fontSize: 30)),
                Text(data["P"], style: TextStyle(fontSize: 30)),
                Text(data["Q"], style: TextStyle(fontSize: 30)),
                Text(data["R"], style: TextStyle(fontSize: 30)),
                Text(data["S"], style: TextStyle(fontSize: 30)),
                Text(data["T"], style: TextStyle(fontSize: 30)),
                Text(data["U"], style: TextStyle(fontSize: 30)),
                Text(data["V"], style: TextStyle(fontSize: 30)),
                Text(data["W"], style: TextStyle(fontSize: 30)),
                Text(data["X"], style: TextStyle(fontSize: 30)),
                Text(data["Y"], style: TextStyle(fontSize: 30)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
