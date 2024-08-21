import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapClickScreen extends StatefulWidget {
  const MapClickScreen({super.key});

  @override
  State<MapClickScreen> createState() => _MapClickScreenState();
}

class _MapClickScreenState extends State<MapClickScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  final storage = const FlutterSecureStorage();

  // String _selectedAddress = '';
  String _selectedStreet = '';
  String _selectedDistrict = '';

  final LatLng _center = const LatLng(43.220189, 76.876802);

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();

    _markers.add(
      Marker(
        markerId: const MarkerId('marker_1'),
        position: const LatLng(43.220189, 76.876802),
        infoWindow: const InfoWindow(title: 'Интересное место 1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('marker_2'),
        position: const LatLng(43.2565, 76.9282),
        infoWindow: const InfoWindow(title: 'Интересное место 2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    );
  }

  Future<void> _setMarkerIcon() async {
    final BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/marker_icon.png',
    );
    _getAddressFromLatLng(_center);
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark place = placemarks[0];
      setState(() async {
        // _selectedAddress = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
        _selectedStreet = '${place.street}';
        _selectedDistrict = '${place.subLocality}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор адреса'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12,
              tilt: 45,
            ),
            onMapCreated: (controller) {
              _controller = controller;

            },
            markers: _markers,
            onCameraMove: (CameraPosition position) {
              setState(() {
                _markers = {
                  Marker(markerId: const MarkerId('center_marker'), position: position.target, alpha: 0),
                };
              });
            },
          ),
          const Positioned.fill(
            top: -35,
            child: Align(
              alignment: Alignment.center,
              child: Icon(Icons.location_on, size: 50, color: Colors.red),
            ),
          ),
        ],
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         _controller?.animateCamera(CameraUpdate.newCameraPosition(
      //           CameraPosition(
      //             target: LatLng(43.2565, 76.9282),
      //             zoom: 17.0,
      //           ),
      //         ));
      //       },
      //       child: Icon(Icons.apartment),
      //     ),
      //   ],
      // ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _getAddressFromLatLng(_markers.first.position);
          Navigator.pop(context);
          // print(_selectedAddress);

          await storage.write(key: 'streetCart', value: _selectedStreet);
          await storage.write(key: 'districtCart', value: _selectedDistrict);

          // print(_selectedStreet);
          // print(_selectedDistrict);
        },
        label: const Text('Выбрать адрес'),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
