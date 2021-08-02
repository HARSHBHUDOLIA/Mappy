abstract class GeocodingEvent {
  const GeocodingEvent();
}

class RequestGeocodingEvent extends GeocodingEvent {
  final double latitude;
  final double longitude;

  RequestGeocodingEvent(this.latitude, this.longitude);
}
