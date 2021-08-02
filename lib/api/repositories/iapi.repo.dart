import 'package:mappy/api/modals/geocoding.modal.dart';

abstract class IApiRepo {
  Future<GeocodingModal?> performGeoCoding(
    double latitude,
    double longitude,
  ) async {}
}
