import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AgreementPage extends StatelessWidget {
  const AgreementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: rootBundle.loadString("assets/md/EULA.md"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget widget;
          if (snapshot.hasData) {
            final data = snapshot.data;
            widget = Markdown(data: data);
          } else if (snapshot.hasError) {
            widget = Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            widget = const CircularProgressIndicator();
          }
          return widget;
        },
      ),
    );
  }
}
