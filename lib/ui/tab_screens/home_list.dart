// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jvdream/blocs/location_bloc.dart';
import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/ui/base/base_ui.dart';
import 'package:jvdream/ui/screens/otherprofile.dart';
import 'package:jvdream/utils/common_widgets/common_style.dart';

// ignore: import_of_legacy_library_into_null_safe
class HomeListUI extends StatefulWidget {
  const HomeListUI({super.key});

  @override
  State<HomeListUI> createState() => _HomeListUIState();
}

class _HomeListUIState extends BaseStatefulState<HomeListUI> {
  String address = "";
  var dictAddressData = <String, String>{};
  List<LocationModel> nearbyLocationList = [];

  @override
  void initState() {
    super.initState();
    // datacall();
    // _listenBlocData();
    // getPosition();
  }

  @override
  Widget build(BuildContext context) {
    contextMain = context;
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
            future: datacall(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: prepareRow(snapshot.data[index])
                          //Text('${snapshot.data[index].address}'),
                          ,
                        );
                      }),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
    // return Scaffold(body: normlList());
  }

/*
  Widget normlList() {
    return isApiCallInProgress
        ? Center(
            child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor),
          )
        : ListView.builder(
            itemCount: nearbyLocationList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(nearbyLocationList[index].address!),
            ),
          );
  }
*/
/*
Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Colors.purple.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(item.image,height: 90,width: 90,),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(item.name,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18))),
            ),
            subtitle: Center(child: Text(item.desc,style: TextStyle(color: Colors.indigo.shade500, fontWeight: FontWeight.bold,fontSize: 15))),
            trailing: Text(
              "\$${item.price}",
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
        ),
      ),
    );
*/
  Widget asyncAPICallBindFutureList() {
    return FutureBuilder(
        future: datacall(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              (snapshot.connectionState == ConnectionState.done)) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: prepareRow(snapshot.data[index]),
                    );
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget prepareRow(LocationModel locationModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtherUserProfile(
                      otherUser: locationModel.userModel,
                      locationModel: locationModel,
                    )));
        print("Column clicked");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidgets.textWidget(
                  '${locationModel.userModel.firstName} ${locationModel.userModel.lastName}',
                ),
                CommonWidgets.textWidget(
                  'Away: ${locationModel.distance}',
                  weight: FontWeight.normal,
                )
              ],
            ),
            Container(
              height: 8,
            ),
            CommonWidgets.textWidget(
              'Email: ${locationModel.userModel.email}',
            ),
            Container(
              height: 6,
            ),
            CommonWidgets.textWidget(
              'Address: ${locationModel.address}',
              weight: FontWeight.normal,
              size: 15,
            ),
            Container(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _eachRowWidget(String title, String? displayValue,
      {TextStyle textStyle = const TextStyle(fontWeight: FontWeight.normal)}) {
    return Row(
      children: [
        Container(
          width: title == "" ? 0 : 100,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: Text(
          displayValue ?? "",
          style: textStyle,
        ))
      ],
    );
  }

  TextStyle textStyleDataForHeader() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  }

  datacall() async {
    var latlong = await _determinePosition();
    //SetData for nearby location
    // setAddressData(latlong);
    //isApiCallInProgress = true;
    Map<String, String> dict = {};
    dict["latitude"] = "${latlong.latitude}";
    dict["longitude"] = "${latlong.longitude}";

    return await locationBloc.nearByLocationListDetails(dict);
    // .then((data) => {print("WOOOO-data$data")
    // arrNearbylist = data;
    // });
  }

  _listenBlocData() {
    locationBloc.streamLocationInfo.listen((response) {
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

    locationBloc.streamNearByInfo.listen((response) {
      if (response.status == 200) {
        var data = response.listLocations;

        // arrNearbylist =futureList.map((e) => CartItemModel.fromJson(e)).toList();

        // return convertedCart;

        setState(() {
          isApiCallInProgress = false;
          nearbyLocationList = data.listLocationData;
        });
      } else {
        print("Something went wronnggggg---");
        SnackbarClass.createSnackBar(response.message, contextMain);
        setState(() {
          isApiCallInProgress = false;
        });
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
    // locationBloc.addLocationDetails(dictAddressData);

    // Map<String, String> dict = {};
    // dict["latitude"] = "${position.latitude}";
    // dict["longitude"] = "${position.longitude}";
    // locationBloc.nearByLocationListDetails(dict);
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
    // setState(() {
    //   address = addressC; // update _address
    // });
  }

/*
Column(
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
*/

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
}
