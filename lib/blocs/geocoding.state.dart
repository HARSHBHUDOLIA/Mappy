// enum GeocodingState {
//   initial,
//   loading,
//   succesful,
//   failed,
// }

import 'package:mappy/api/modals/geocoding.modal.dart';

abstract class GeocodingState {
  const GeocodingState();
}

class InitialGeocodingState extends GeocodingState {}

class LoadingGeocodingState extends GeocodingState {}

class SuccesfulGeocodingState extends GeocodingState {
  final GeocodingModal data;
  const SuccesfulGeocodingState(this.data);
}

class FailGeocodingState extends GeocodingState {
  final String error;
  const FailGeocodingState({this.error = 'Error Occured'});
}
