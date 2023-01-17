import 'package:jvdream/models/friend_model.dart';
import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/resources/repository.dart';
import 'package:rxdart/subjects.dart';

class FriendshpBloc {
  final frndRepo = FriendsRepository();

  final _frndFetcher = PublishSubject<FriendDataResponse>();
  Stream<FriendDataResponse> get streamFrndStatusInfo => _frndFetcher.stream;

  // final _nearBylocationFetcher = PublishSubject<NearbyLocationResponse>();
  // Stream<NearbyLocationResponse> get streamNearByInfo =>
  //     _nearBylocationFetcher.stream;

  getFriendStatus(Map<String, String> reqData) async {
    var data = await frndRepo.getFriendStatusDetails(reqData);
    print("Add location response - $data");
    _frndFetcher.sink.add(data);
    return data;
  }

  asPerActionPassUrl(Map<String, String> reqData, String url) async {
    var data = await frndRepo.doAsPerRequested(reqData, url);
    print("Add location response - $data");
    _frndFetcher.sink.add(data);
    return data;
  }
}

final friendshpBloc = FriendshpBloc();
