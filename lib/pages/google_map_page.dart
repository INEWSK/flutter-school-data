import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    // setup marker
    _setMarker(_hongKong);
  }

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
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: _hongKong, zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Locate'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }
}
