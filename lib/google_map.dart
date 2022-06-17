import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartking/provider/address_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Googlemap extends StatefulWidget {
  const Googlemap({Key? key}) : super(key: key);

  @override
  State<Googlemap> createState() => _GooglemapState();
}

class _GooglemapState extends State<Googlemap> {
  final LatLng _latLng = const LatLng(20.5937, 78.9629);
  GoogleMapController? controller;
  final Location _location = Location();
  void _onmapcreated(GoogleMapController contrl) {
    controller = contrl;
    _location.onLocationChanged.listen((event) {
      controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              event.latitude!,
              event.longitude!,
            ),
            zoom: 15),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Addressprovider addressProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(target: _latLng),
                mapType: MapType.normal,
                onMapCreated: _onmapcreated,
                myLocationEnabled: true,
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        left: 10, right: 60, bottom: 40, top: 40),
                    child: MaterialButton(
                      onPressed: () async {
                        await _location.getLocation().then((value) {
                          setState(() {
                            addressProvider.setlocation = value;
                          });
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      color: primarycolor,
                      shape: const StadiumBorder(),
                      child: const Text('Set Location'),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
