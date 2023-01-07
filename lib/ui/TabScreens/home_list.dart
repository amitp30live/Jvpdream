// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jvdream/blocs/location_bloc.dart';
import 'package:jvdream/ui/initial_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: import_of_legacy_library_into_null_safe
class HomeListUI extends StatefulWidget {
  const HomeListUI({super.key});

  @override
  State<HomeListUI> createState() => _HomeListUIState();
}

class _HomeListUIState extends State<HomeListUI> {
  String address = "";
  var dictAddressData = <String, String>{};

  @override
  void initState() {
    super.initState();

    datacall();
    getPosition();
  }

  datacall() async {
    var latlong = await _determinePosition();
    setAddressData(latlong);
  }

  _listenBlocData() {
    locationBloc.streamUserInfo.listen((response) {
      if (response.status == 200) {
        // setState(() {
        //   isApiCallInProgress = false;
        // });
      } else {
        print("Something went wronnggggg---");
        //SnackbarClass.createSnackBar(response.message, contextMain);
        // setState(() {
        //   isApiCallInProgress = false;
        // });
      }
    });
  }

  void setAddressData(Position position) async {
    var placemarks = await getAddress(position);

    // this is all you need
    Placemark placeMark = placemarks[0];
    print(placeMark.toJson());
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String? addressC =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

    dictAddressData["address"] = addressC;
    dictAddressData["name"] = name ?? "";

    dictAddressData["city"] = locality ?? "";
    dictAddressData["state"] = administrativeArea ?? "";
    dictAddressData["country"] = country ?? "";
    dictAddressData["pincode"] = postalCode ?? "";
// position.latitude, position.longitude
    dictAddressData["latitude"] = "${position.latitude}";
    dictAddressData["longitude"] = "${position.longitude}";

    print(addressC);
    await locationBloc.addLocationDetails(dictAddressData);
    /*
  flutter: {name: New SG Road, street: New SG Road, isoCountryCode: IN, country: India,
   postalCode: 382481, administrativeArea: GJ, subAdministrativeArea: Ahmedabad, 
   locality: Ahmedabad, subLocality: Gota, thoroughfare: New SG Road, subThoroughfare: }

  address:Himalaya Mall, Drive In Rd, Nilmani Society, Gurukul, Ahmedabad, Gujarat 380006
city:Ahmedabad
state:Gujarat
country:India
pincode:380006
latitude:23.0463768
longitude:72.5266095
contactObj:63b83e2458108e5704758ebd
  'name': name,
        'street': street,
        'isoCountryCode': isoCountryCode,
        'country': country,
        'postalCode': postalCode,
        'administrativeArea': administrativeArea,
        'subAdministrativeArea': subAdministrativeArea,
        'locality': locality,
        'subLocality': subLocality,
        'thoroughfare': thoroughfare,
        'subThoroughfare': subThoroughfare,
    */
    setState(() {
      address = addressC; // update _address
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(address.isEmpty
                  ? "Show Address"
                  : "Current Address :$address"),
              TextButton(
                  onPressed: () {
                    _doOpenPage(context);
                  },
                  child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
    return position;
  }

  getPosition() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
      if (position != null) {
        setAddressData(position);
      }
    });
  }

  Future<List<Placemark>> getAddress(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks;
  }

  void _doOpenPage(BuildContext contextMain) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');

    // Navigator.of(context, rootNavigator: true).pop().;

    Navigator.pushAndRemoveUntil(contextMain,
        MaterialPageRoute(builder: (context) {
      return InitialUI();
    }), ModalRoute.withName('/'));
  }
}
