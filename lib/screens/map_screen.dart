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
  // Controller gives access to google map features once it's ready
  final Completer<GoogleMapController> _controller = Completer();

  // Entry point to access device location
  Location location;

  // Markers that will be plotted on map
  Set<Marker> currentLocationMarker = Set<Marker>();

  // Will be used to close location stream after dispose
  StreamSubscription locationStreamSubscription;

  @override
  void initState() {
    super.initState();
    initLocationOfUser();
  }

  /// Handles configuration and fetching location
  Future<void> initLocationOfUser() async {
    // Entry point to access device location
    location = new Location();

    // Ask for location after every 30 secs
    location.changeSettings(interval: 30000);

    // Check location permission
    bool hasLocationPermission = await location.hasPermission();

    bool permissionGranted = true;

    // Ask for location permission
    if (!hasLocationPermission) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted) {
      // Get the current location
      LocationData currentLocation = await location.getLocation();
      if (mounted && currentLocation != null) {
        onLocationChanged(currentLocation);
      }

      // Setup listener when user's current location is changed
      locationStreamSubscription =
          location.onLocationChanged().listen((LocationData locationData) {
        if (mounted) onLocationChanged(locationData);
      });
    }
  }

  /// Plot user's current location on map as a marker
  Future<void> onLocationChanged(LocationData locationData) async {
    if (locationData != null) {
      // Prepare new location
      LatLng newLoc = LatLng(locationData.latitude, locationData.longitude);

      GoogleMapController googleMapController = await _controller.future;

      // Animate map to new camera position
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: newLoc, zoom: 12.0),
        ),
      );

      setState(() {
        // Clear previous location and push new one
        currentLocationMarker.clear();
        currentLocationMarker.add(Marker(
          markerId: MarkerId("current-loc"),
          position: newLoc,
          infoWindow:
              InfoWindow(title: AppLocalizations.of(context).currentLocation),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(AppDrawer.MAP_POS),
      appBar: _buildAppBar(context),
      body: WillPopScope(
          onWillPop: () async {
            await Navigator.of(context).pushReplacementNamed("/");
            return false;
          },
          child: _buildGoogleMap()),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: Text(
          AppLocalizations.of(context).mapTitle,
          overflow: TextOverflow.ellipsis,
        ),
      );

  GoogleMap _buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: currentLocationMarker,
      initialCameraPosition:
          const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 4),
      // Initial camera position to India
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    // Cancel location stream
    locationStreamSubscription?.cancel();
  }
}
