import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({
    Key? key,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.school,
    required this.address,
  }) : super(key: key);

  final String id;
  final double latitude;
  final double longitude;
  final String school;
  final String address;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng _hongKong = const LatLng(22.3939351, 114.1561875);

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  // Future<void> _locate() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_position));
  // }

  void _setMarker({
    required String id,
    required LatLng position,
    required String school,
    required String address,
  }) {
    final Marker marker = Marker(
        markerId: MarkerId(id),
        position: position,
        infoWindow: InfoWindow(title: school, snippet: address));

    setState(() {
      _markers[MarkerId(id)] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.id;
    final position = LatLng(widget.latitude, widget.longitude);
    final school = widget.school;
    final address = widget.address;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: position, zoom: 15),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _setMarker(
                id: id,
                position: position,
                school: school,
                address: address,
              );
            },
            markers: Set<Marker>.of(_markers.values),
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
