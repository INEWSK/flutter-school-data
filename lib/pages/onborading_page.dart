import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../common/demo/demo.dart';
import '../components/dot_indicator.dart';
import '../generated/l10n.dart';
import 'main_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;

  void _onIntroEnd(context) {
    var box = Hive.box('common_box');
    // * FOR remember the user already seen the demo
    box.put('seen', true);
    // * Replace the current route to MainPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  Widget _onBoardContent(
      {required String svg, required String title, required String text}) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            //長寬比 1:1
            aspectRatio: 1,
            child: SvgPicture.asset(svg),
          ),
        ),
        const SizedBox(height: 50),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // * deactivated user press back button to exit this page
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              Expanded(
                flex: 9,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  // demo data content
                  itemCount: demoOnBoardingData.length,
                  itemBuilder: (context, index) => _onBoardContent(
                    svg: demoOnBoardingData[index]["svg"],
                    title: demoOnBoardingData[index]["title"],
                    text: demoOnBoardingData[index]["text"],
                  ),
                ),
              ),
              const Spacer(),
              // dot indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(demoOnBoardingData.length,
                    (index) => DotIndicator(isActive: index == currentPage)),
              ),
              const Spacer(flex: 2),
              // primary button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () => _onIntroEnd(context),
                  child: Text(S.of(context).getStart),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      // * disable user pop behavior
      onWillPop: () async => false,
    );
  }
}
