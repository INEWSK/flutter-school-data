import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/school.dart';
import '../provider/intl_provider.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({
    Key? key,
    required this.school,
    required this.data,
  }) : super(key: key);

  // * for two different display
  final School school;
  final List<School> data;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng _hongKong = const LatLng(22.3939351, 114.1561875);
  // final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  List<Marker> _markers = [];

  void _setMarker({
    required School school,
    required List<School> data,
  }) {
    final Locale locale = context.read<IntlProvider>().locale;
    // * if school object is not empty
    if (school.a != null) {
      final id = widget.school.a!;
      final position = LatLng(
          double.parse(widget.school.j!), double.parse(widget.school.h!));
      final cnSchoolName = widget.school.e!;
      final cnSchoolAddr = widget.school.g!;
      final enSchoolName = widget.school.d!;
      final enSchoolAddr = widget.school.f!;

      final List<Marker> marker = [];
      marker.add(Marker(
        markerId: MarkerId(id),
        position: position,
        infoWindow: InfoWindow(
          title:
              locale == const Locale('zh', 'HK') ? cnSchoolName : enSchoolName,
          snippet:
              locale == const Locale('zh', 'HK') ? cnSchoolAddr : enSchoolAddr,
        ),
      ));
      setState(() {
        _markers = marker;
      });
    }

    // * if list of school is not empty
    if (data.isNotEmpty) {
      final List<Marker> markers = [];
      for (var element in data) {
        final LatLng position = LatLng(
          double.parse(element.j!),
          double.parse(element.h!),
        );
        markers.add(
          Marker(
            markerId: MarkerId(element.a!),
            position: position,
            infoWindow: InfoWindow(
                title:
                    locale == const Locale('zh', 'HK') ? element.e : element.d,
                snippet:
                    locale == const Locale('zh', 'HK') ? element.g : element.f),
          ),
        );
      }
      setState(() {
        _markers = markers;
      });
    }
  }

  Future<void> _locateSchool(School school) async {
    if (school.a != null) {
      final LatLng position = LatLng(
        double.parse(school.j!),
        double.parse(school.h!),
      );
      final c = await _controller.future;
      CameraPosition cameraPosition =
          CameraPosition(target: position, zoom: 16.0);
      c.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  @override
  Widget build(BuildContext context) {
    final school = widget.school;
    final data = widget.data;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: _hongKong, zoom: 10.5),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _setMarker(
                school: school,
                data: data,
              );
              // * update camera to the school position when google map init
              _locateSchool(school);
            },
            markers: Set<Marker>.of(_markers),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Text('Locate'),
      //   icon: const Icon(Icons.location_on),
      // ),
    );
  }
}
