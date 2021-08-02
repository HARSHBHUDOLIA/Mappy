import 'package:mappy/api/modals/geocoding.modal.dart';

import '../api.const.dart';
import '../providers/api.provider.dart';
import 'iapi.repo.dart';

class ApiRepo {
  final ApiProvider _provider = ApiProvider(baseUrl: MAP_BOX_BASE_URL);
  static final ApiRepo instance = ApiRepo._();
  ApiRepo._();

  Future<GeocodingModal> performGeoCoding(
    double latitude,
    double longitude,
  ) async {
    final result = await _provider.makeGetRequest(
        'geocoding/v5/mapbox.places/$longitude,$latitude.json',
        queryParams: {
          'types': 'region',
          'access_Token': 'Your ACcess Token',
        });

    if (result != null) {
      return GeocodingModal.fromjson(result);
    } else {
      return GeocodingModal();
    }
  }
}
