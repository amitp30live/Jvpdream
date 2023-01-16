import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/resources/repository.dart';
import 'package:rxdart/subjects.dart';

class LocationBloc {
  final locRepo = LocationRepository();

  final _locationFetcher = PublishSubject<LocationResponse>();
  Stream<LocationResponse> get streamLocationInfo => _locationFetcher.stream;

  final _nearBylocationFetcher = PublishSubject<NearbyLocationResponse>();
  Stream<NearbyLocationResponse> get streamNearByInfo =>
      _nearBylocationFetcher.stream;

  addLocationDetails(Map<String, String> locationData) async {
    var data = await locRepo.addLocationDetails(locationData);
    if (data != null) {
      print("Add location response - $data");
      // return _locationFetcher.sink.add(data);
    }
  }

  nearByLocationListDetails(Map<String, String> locationData) async {
    var data = await locRepo.nearbyLocationListDetails(locationData);
    if (data != null) {
      _nearBylocationFetcher.sink.add(data);
      return data.listLocations.listLocationData;
    }
  }
}

final locationBloc = LocationBloc();
