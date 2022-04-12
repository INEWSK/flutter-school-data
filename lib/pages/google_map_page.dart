import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({
    Key? key,
    required this.id,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final String id;
  final double latitude;
  final double longitude;

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

  void _setMarker(LatLng position) {
    final Marker marker = Marker(
        markerId: MarkerId('id'),
        position: position,
        infoWindow: InfoWindow(title: 'Title', snippet: 'Address'));

    setState(() {
      _markers[MarkerId('id')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _position = LatLng(widget.latitude, widget.longitude);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: _position, zoom: 15),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _setMarker(_position);
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
