// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:ecom_app/core/constants/enum.dart';
import 'package:ecom_app/core/services/permission_service.dart';
import 'package:geolocator/geolocator.dart';

mixin LocationMixin {
  Future<LocationModel> getCurrentLocation() async {
    final completer = Completer<LocationModel>();

    PermissionService.requestPermission(
      permissionFor: PermissionFor.location,
      onGrantedCallback: () async {
        try {
          final position = await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
          );

          completer.complete(
            LocationModel(
              latitude: position.latitude,
              longitude: position.longitude,
              isPermissionGranted: true,
            ),
          );
        } catch (e) {
          completer.complete(
            LocationModel(
              latitude: 0.0,
              longitude: 0.0,
              isPermissionGranted:
                  true, // Permission granted, but location failed
            ),
          );
        }
      },
      onDeniedCallback: () {
        completer.complete(
          LocationModel(
            latitude: 0.0,
            longitude: 0.0,
            isPermissionGranted: false,
          ),
        );
      },
      onOthersDeniedCallback: (_) {
        completer.complete(
          LocationModel(
            latitude: 0.0,
            longitude: 0.0,
            isPermissionGranted: false,
          ),
        );
      },
    );

    return completer.future;
  }
}

class LocationModel {
  double? latitude;
  double? longitude;
  bool? isPermissionGranted;

  LocationModel({this.latitude, this.longitude, this.isPermissionGranted});

  @override
  String toString() =>
      'LocationModel(latitude: $latitude, longitude: $longitude, isPermissionGranted: $isPermissionGranted)';
}
