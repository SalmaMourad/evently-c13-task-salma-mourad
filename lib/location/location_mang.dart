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
      // if (!_serviceEnabled) {
      //   return;
      // }
    }
    return _serviceEnabled;
  }

  Future<bool> isLocPermissionGranted() async {
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      // if (_permissionGranted != PermissionStatus.granted) {
      //   return;
      // }
    }
    return _permissionGranted == PermissionStatus.granted;
  }

  Future<bool> isCanHaveLocation() async {
    final serviceEnabled=await isLocServiceEnabled();
    final permissionGranted =await isLocPermissionGranted();
    return serviceEnabled && permissionGranted;
  }
  Future <LocationData> getUserLocation()async{
    // _locationData=await location.getLocation();
    return location.getLocation();
  }
// _locationData = await location.getLocation();
}
