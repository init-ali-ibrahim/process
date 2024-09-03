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
  final TextEditingController _searchController = TextEditingController();

  final storage = const FlutterSecureStorage();

  // String _selectedAddress = '';
  String _selectedStreet = '';
  String _selectedDistrict = '';

  final LatLng _center = const LatLng(43.220189, 76.876802);

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
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
        _selectedStreet = '${place.street}';
        _selectedDistrict = '${place.subLocality}';
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _searchAndNavigate() async {
  //   try {
  //     List<Location> locations = await locationFromAddress(_searchController.text);
  //     if (locations.isNotEmpty) {
  //       final LatLng target = LatLng(locations[0].latitude, locations[0].longitude);
  //       _controller?.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(target: target, zoom: 15.0),
  //       ));
  //       setState(() {
  //         _markers.clear();
  //         _markers.add(Marker(markerId: const MarkerId('searched_location'), position: target));
  //       });
  //       await _getAddressFromLatLng(target);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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

                _markers.add(
                  Marker(
                    markerId: const MarkerId('marker_2'),
                    position: const LatLng(43.2565, 76.9282),
                    infoWindow: const InfoWindow(title: 'Интересное место 2'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                  ),
                );
              });
            },
          ),

          // Positioned(
          //   top: 10.0,
          //   left: 15.0,
          //   right: 15.0,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //     color: Colors.white,
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: TextField(
          //             controller: _searchController,
          //             decoration: const InputDecoration(
          //               hintText: 'Введите адрес',
          //               border: InputBorder.none,
          //             ),
          //           ),
          //         ),
          //         IconButton(
          //           icon: const Icon(Icons.search),
          //           onPressed: _searchAndNavigate,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          const Positioned.fill(
            top: -35,
            child: Align(
              alignment: Alignment.center,
              child: Icon(Icons.location_on, size: 50, color: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _getAddressFromLatLng(_markers.first.position);
          Navigator.pop(context);

          await storage.write(key: 'streetCart', value: _selectedStreet);
          await storage.write(key: 'districtCart', value: _selectedDistrict);
        },
        label: const Text('Выбрать адрес'),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

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

    );
  }
}
