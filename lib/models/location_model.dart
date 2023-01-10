import 'package:jvdream/models/base_response.dart';
import 'package:jvdream/models/user_model.dart';

class NearbyLocationList {
  late List<LocationModel> listLocationData;

  NearbyLocationList.fromJson(List<dynamic> parsedJson) {
    List<LocationModel> listData = [];
    for (int i = 0; i < parsedJson.length; i++) {
      listData.add(LocationModel.fromNearbyListJson(parsedJson[i]));
    }
    listLocationData = listData;
  }

  NearbyLocationList.dummy() {
    listLocationData = [];
  }
}

class LocationModel {
  late UserModel userModel;
  String? address;
  String? city;
  String? country;
  String? pincode;
  String? state;

  String? distance;
  Coordinates? coordinates;

  LocationModel.fromJson(Map<String, dynamic> parsedJson) {
    userModel = UserModel.fromLocationJson(parsedJson["contactObj"]);
    address = parsedJson["address"];
    city = parsedJson["city"];
    country = parsedJson["country"];
    pincode = parsedJson["pincode"].toString();
    state = parsedJson["state"];
    Map<String, dynamic> locationData = parsedJson["location"];
    if (locationData.length > 0) {
      List<dynamic> data = locationData["coordinates"];
      coordinates = Coordinates.fromJson(data);
    }
    print(parsedJson["location"][1]);
  }

  LocationModel.fromNearbyListJson(Map<String, dynamic> parsedJson) {
    userModel = UserModel.fromLocationJson(parsedJson["result"]);
    address = parsedJson["address"];
    city = parsedJson["city"];
    country = parsedJson["country"];
    pincode = parsedJson["pincode"].toString();

    var data = parsedJson["distance"].toDouble() / 1000;
    var distanceKM = data.toStringAsFixed(2);
    distance = "$distanceKM Km";

    state = parsedJson["state"];
    Map<String, dynamic> locationData = parsedJson["location"];
    if (locationData.length > 0) {
      List<dynamic> data = locationData["coordinates"];
      coordinates = Coordinates.fromJson(data);
    }
    print(parsedJson["location"][1]);
  }

  LocationModel.dummy() {
    userModel = UserModel.dummy();
  }

  LocationModel({required this.userModel});
}

class Coordinates {
  late String latitude;
  late String longitude;

  Coordinates.fromJson(List<dynamic> data) {
    if (data.length > 0) {
      latitude = data[1].toString();
      longitude = data[0].toString();
    }
  }
}

class LocationResponse extends BaseDataRes {
  LocationModel locationModel;

  LocationResponse(
      {required this.locationModel,
      required super.status,
      required super.message});
}

class NearbyLocationResponse extends BaseDataRes {
  NearbyLocationList listLocations;

  NearbyLocationResponse(
      {required this.listLocations,
      required super.status,
      required super.message});
}
/*
 "data": {
        "location": {
            "type": "Point",
            "coordinates": [
                72.5266095,
                23.0463768
            ]
        },
        "_id": "63b83e85c5d0c8ed1f6b1b2a",
        "contactObj": {
            "_id": "63b83e2458108e5704758ebd",
            "firstName": "Bhavik",
            "lastName": "p",
            "email": "bhavik@gmail.com"
        },
        "__v": 0,
        "address": "Himalaya Mall, Drive In Rd, Nilmani Society, Gurukul, Ahmedabad, Gujarat 380006",
        "city": "Ahmedabad",
        "country": "India",
        "created_at": "2023-01-06T15:30:13.314Z",
        "pincode": 380006,
        "state": "Gujarat",
        "updated_at": "2023-01-06T15:30:13.314Z"
    },
    "message": "Location details added successfully.."
*/