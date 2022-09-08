import 'package:flutter/material.dart';
import 'package:flutter101/src/pages/nearby_store_page/nearby_store_page_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyStorePage extends StatelessWidget {
  NearbyStorePage({Key? key}) : super(key: key);

  final _nearbyStorePageController = Get.put(NearbyStorePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        builder: (NearbyStorePageController nearbyStorePageController) {
          return GoogleMap(
            mapType: MapType.normal,
            markers: _nearbyStorePageController.marker,
            initialCameraPosition: _nearbyStorePageController.fabLocation,
            onMapCreated: (GoogleMapController controller) {
              _nearbyStorePageController.controller.complete(controller);
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _nearbyStorePageController.goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}
