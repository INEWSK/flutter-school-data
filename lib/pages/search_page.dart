import 'package:flutter/material.dart';
import 'package:flutter_school_information/common/utils/toast_utils.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;

  showMessage() {
    Toast.show('123');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Icon(Icons.abc),
            Text('123'),
            ElevatedButton(onPressed: () => showMessage(), child: Text('123')),
          ],
        ),
      ),
    );
  }
}
