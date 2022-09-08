import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter101/core/Lifecycle/LifecycleListener.dart';
import 'package:flutter101/core/Lifecycle/LifecycleListenerEvent.dart';
import 'package:flutter101/core/config/routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyStorePageController extends GetxController
    with LifecycleListenerEvent {
  late LifecycleListener _lifecycleListener;
  bool isOpenAppSetting = false;
  Completer<GoogleMapController> controller = Completer();

  final CameraPosition _defLocation = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final CameraPosition _defLocationCamera = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final CameraPosition fabLocation = const CameraPosition(
    target: LatLng(13.7021, 100.5415),
  );

  LatLng? _currentDeviceLocation;

  CameraPosition get currentDeviceLocation {
    return _currentDeviceLocation != null
        ? CameraPosition(
            target: LatLng(
              _currentDeviceLocation!.latitude,
              _currentDeviceLocation!.longitude,
            ),
            zoom: 14,
          )
        : _defLocation;
  }

  Future<void> goToTheLake() async {
    final GoogleMapController c = await controller.future;
    c.animateCamera(CameraUpdate.newCameraPosition(fabLocation));
  }

  final Set<Marker> marker = {};

  @override
  void onInit() {
    super.onInit();
    _lifecycleListener = LifecycleListener(providerInstance: this);

    _moveCameraToCurrentLocation();
    _addMarker();
  }


  @override
  void onClose() {
    _lifecycleListener.dispose();
  }

  void _moveCameraToCurrentLocation() async {
    try {
      final position = await _determinePosition();

      _currentDeviceLocation = LatLng(position.latitude, position.longitude);

      final GoogleMapController controller = await this.controller.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(currentDeviceLocation));
    } catch (e) {
        _openAppSetting(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _addMarker() async {
    marker.add(const Marker(
        markerId: MarkerId("1"),
        position: LatLng(13.7021, 100.5415),
        infoWindow: InfoWindow(
          title: 'Nerby store1',
          snippet: "First exclusive store",
        ),
        icon: BitmapDescriptor.defaultMarker));
    final Uint8List? markerIcon =
        await getBytesFromAsset("assets/pin.png", 100);
    marker.add(
      Marker(
        markerId: const MarkerId("2"),
        position: const LatLng(13.7012, 100.5429),
        infoWindow: const InfoWindow(
          title: 'Nearby store 2',
          snippet: 'Second exclusive store',
        ),
        icon: BitmapDescriptor.fromBytes(markerIcon!),
      ),
    );

    update();
  }

  void _openAppSetting(String message) {
    Get.dialog(
      AlertDialog(
        title: Text("ไม่สามารถเข้าถึงตำแหน่งได้"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Get.back(closeOverlays: true);
              },
              child: Text("ยกเลิก")),
          TextButton(
              onPressed: () async {
                // Get.back();
                Navigator.of(Get.overlayContext!).pop();

                if (Platform.isAndroid) {
                  isOpenAppSetting= await Geolocator.openAppSettings();
                  _moveCameraToCurrentLocation();
                  return;
                } else if (Platform.isIOS) {
                  isOpenAppSetting = await Geolocator.openAppSettings();
                  isOpenAppSetting = await Geolocator.openLocationSettings();
                  return;
                }
              },
              child: Text("ตกลง")),
        ],
      ),
    );
  }

  var a = true;

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  @override
  void onResume() {
    super.onResume();

    if (Get.currentRoute == Routes.nearbyStorePage && isOpenAppSetting) {
      isOpenAppSetting = false;
      _moveCameraToCurrentLocation();
    }
  }
}
