import 'package:flutter101/core/flavor/flavor_config.dart';
import 'package:flutter101/main.dart';

void main(){
  FlavorConfig(
      flavor: Flavor.PRODUCTION,
      values: FlavorValues(
        baseUrl: "https://prd",
      )
  );

  mainApp();
}