import 'package:flutter101/core/flavor/flavor_config.dart';
import 'package:flutter101/main.dart';

void main(){
  FlavorConfig(
    flavor: Flavor.DEV,
    values: FlavorValues(
      baseUrl: "https://dev",
    )
  );

  mainApp();
}