import 'package:jvdream/models/base_response.dart';
import 'package:jvdream/models/user_model.dart';

class LocationModel {
  late UserModel userModel;
  String? address;
  String? city;
  String? country;
  String? pincode;
  String? state;
  Coordinates? coordinates;

  LocationModel.fromJson(Map<String, dynamic> parsedJson) {
    userModel = UserModel.fromJson(parsedJson["contactObj"]);
    address = parsedJson["address"];
    city = parsedJson["city"];
    country = parsedJson["country"];
    pincode = parsedJson["pincode"];
    state = parsedJson["state"];
    coordinates = Coordinates.fromJson(parsedJson["coordinates"]);
  }

  LocationModel({required this.userModel});
}

class Coordinates {
  late String latitude;
  late String longitude;

  Coordinates.fromJson(List<int> data) {
    if (data.isNotEmpty) {
      latitude = data[1].toString();
      longitude = data[0].toString();
    }
  }
}

class LocationResponse extends BaseResponse {
  LocationModel locationModel;

  LocationResponse(
      {required this.locationModel,
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