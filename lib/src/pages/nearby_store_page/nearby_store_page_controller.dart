import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyStorePageController extends GetxController {
  Completer<GoogleMapController> controller = Completer();

   final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

   final CameraPosition kLake =const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> goToTheLake() async {
    final GoogleMapController c = await controller.future;
    c.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }
}
