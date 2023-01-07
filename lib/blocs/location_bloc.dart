import 'package:jvdream/models/location_model.dart';
import 'package:jvdream/resources/auth_repository.dart';
import 'package:rxdart/subjects.dart';

class LocationBloc {
  final locRepo = LocationRepository();

  final _locationFetcher = PublishSubject<LocationResponse>();
  Stream<LocationResponse> get streamUserInfo => _locationFetcher.stream;

  addLocationDetails(Map<String, String> locationData) async {
    var data = await locRepo.addLocationDetails(locationData);
    if (data != null) {
      return _locationFetcher.sink.add(data);
    }
  }
}

final locationBloc = LocationBloc();
