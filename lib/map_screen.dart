import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  String? _latitude, _longitude;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   getLocation();
    // });

    getLocation();
  }

  void getLocation() async {
    var location = await currentLocation.getLocation();
    print(location);
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      _latitude = loc.latitude.toString();
      _longitude = loc.longitude.toString();
      // setState(() {
      //   _markers.add(Marker(
      //       markerId: MarkerId('Home'),
      //       position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      // });
      _markers.add(Marker(
          markerId: const MarkerId('Home'),
          position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: const CameraPosition(
            target: LatLng(48.8561, 2.2930),
            zoom: 12.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: _markers,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff278cbd),
        child: const Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () {
          getLocation();
        },
      ),
    );
  }
}
