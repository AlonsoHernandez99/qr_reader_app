import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryMapsPage extends StatefulWidget {
  @override
  _HistoryMapsPageState createState() => _HistoryMapsPageState();
}

class _HistoryMapsPageState extends State<HistoryMapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapsType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    final CameraPosition _initialPoint =
        CameraPosition(target: scanModel.getLatLng(), zoom: 17.5, tilt: 50);

    Set<Marker> markers = new Set<Marker>();
    markers.add(Marker(
        markerId: MarkerId('get-location'), position: scanModel.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
        actions: [
          IconButton(
              icon: Icon(Icons.location_history),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scanModel.getLatLng(), zoom: 17.5, tilt: 50)));
              })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapsType,
        markers: markers,
        initialCameraPosition: _initialPoint,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            if (mapsType == MapType.normal) {
              mapsType = MapType.satellite;
            } else {
              mapsType = MapType.normal;
            }
          });
        },
      ),
    );
  }
}
