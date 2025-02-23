import 'package:location/location.dart';

class LocationMang {
  Location location = Location();

  bool _serviceEnabled = false;
  final PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  Future<bool> isLocServiceEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    return _serviceEnabled;
  }

  Future<bool> isLocPermissionGranted() async {
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    return _permissionGranted == PermissionStatus.granted;
  }

  Future<bool> isCanHaveLocation() async {
    final serviceEnabled = await isLocServiceEnabled();
    final permissionGranted = await isLocPermissionGranted();
    return serviceEnabled && permissionGranted;
  }

  Future<LocationData> getUserLocation() async {
    return location.getLocation();
  }
}
