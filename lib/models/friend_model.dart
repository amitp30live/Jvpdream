import 'package:jvdream/models/base_response.dart';

class FriendModel {
  late String sid;
  late String requesterId;
  late String recipientId;
  //Ignore this status
  late String status;

  FriendModel(this.sid, this.recipientId, this.requesterId, this.status);

  FriendModel.fromJson(Map<String, dynamic> parsedJson) {
    sid = parsedJson["_id"];
    requesterId = parsedJson["requesterId"];
    recipientId = parsedJson["recipientId"];
    status = parsedJson["status"];
  }
}

/*
Show Respond to request Accept/Decline
{
    "message": "Pending request.. Show Accept & Decline..",
    "status": "RespondToRequest",
    "data": {
        "_id": "63c4d621a28cb26d9898d0c9",
        "requesterId": "63a1a3eee9771f5ce0732233",
        "recipientId": "63b7dc8fa10ddd23ff675f28",
        "status": "requested",
        "createdAt": "2023-01-16T04:44:17.789Z",
        "updatedAt": "2023-01-16T04:44:17.789Z",
        "__v": 0
    }
}
*/
class FriendDataResponse extends BaseDataRes {
  late String reqStatus;
  FriendModel? friendModel;
  FriendDataResponse(
      {required reqStatus,
      friendModel,
      required super.status,
      required super.message});
}
