import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mappy/api/repositories/api.repo.dart';
import 'package:mappy/blocs/geocoding.event.dart';
import 'package:mappy/blocs/geocoding.state.dart';

class GeocodingBloc extends Bloc<GeocodingEvent, GeocodingState> {
  final ApiRepo _repo = ApiRepo.instance;
  GeocodingBloc() : super(InitialGeocodingState());
  var result;
  @override
  Stream<GeocodingState> mapEventToState(GeocodingEvent event) async* {
    if (event is RequestGeocodingEvent) {
      yield LoadingGeocodingState();
      result = await _repo.performGeoCoding(event.latitude, event.longitude);
    }
    if (result.placeName.isNotEmpty()) {
      yield SuccesfulGeocodingState(result);
    } else {
      yield FailGeocodingState(error: 'Geocoding failed');
    }
    throw UnimplementedError();
  }
}
