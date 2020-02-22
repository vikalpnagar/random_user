import 'dart:async';

import 'package:random_user/app/app_localizations.dart';
import 'package:random_user/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = "map-screen";

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Location location;
  Set<Marker> currentLocationMarker = Set<Marker>();
  StreamSubscription locationStreamSubscription;

  @override
  void initState() {
    super.initState();
    initLocationOfUser();
  }

  Future<void> initLocationOfUser() async {
    location = new Location();
    location.changeSettings(interval: 30000);

    bool hasLocationPermission = await location.hasPermission();

    bool permissionGranted = true;

    if (!hasLocationPermission) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted) {
      LocationData currentLocation = await location.getLocation();
      print(
          "initLocationOfUser: currentLocation--->${currentLocation
              .latitude}, ${currentLocation.longitude}");
      if (mounted && currentLocation != null) {
        onLocationChanged(currentLocation);
      }

      locationStreamSubscription = location.onLocationChanged().listen((LocationData locationData) {
        print(
            "initLocationOfUser: onLocationChanged--->${locationData
                .latitude}, ${locationData.longitude}");
        if (mounted)
          onLocationChanged(locationData);
      });
    }
  }

  Future<void> onLocationChanged(LocationData locationData) async {
    if (locationData != null) {
      LatLng newLoc = LatLng(locationData.latitude, locationData.longitude);

      GoogleMapController googleMapController = await _controller.future;

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: newLoc, zoom: 12.0),
        ),
      );

      setState(() {
        currentLocationMarker.clear();
        currentLocationMarker.add(Marker(
          markerId: MarkerId("current-loc"),
          position: newLoc,
          infoWindow:
          InfoWindow(title: AppLocalizations
              .of(context)
              .currentLocation),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: _buildAppBar(context),
      body: _buildGoogleMap(),
    );
  }

  AppBar _buildAppBar(BuildContext context) =>
      AppBar(
        title: Text(
          AppLocalizations
              .of(context)
              .mapTitle,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: currentLocationMarker,
      initialCameraPosition:
      const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 4),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    locationStreamSubscription?.cancel();
  }
}
