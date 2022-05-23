import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartking/address_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Googlemap extends StatefulWidget {
  Googlemap({Key? key}) : super(key: key);

  @override
  State<Googlemap> createState() => _GooglemapState();
}

class _GooglemapState extends State<Googlemap> {
  LatLng _latLng = LatLng(20.5937, 78.9629);
  GoogleMapController? controller;
  Location _location = Location();
  void _onmapcreated(GoogleMapController _contrl) {
    controller = _contrl;
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
    addressprovider addressProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
      ),
      body: SafeArea(
        child: Container(
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
                    margin: EdgeInsets.only(
                        left: 10, right: 60, bottom: 40, top: 40),
                    child: MaterialButton(
                      onPressed: () async {
                        await _location.getLocation().then((value) {
                          setState(() {
                            addressProvider.setlocation = value;
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      color: primarycolor,
                      child: Text('Set Location'),
                      shape: StadiumBorder(),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
