class GeocodingModal {
  double? latitude;
  double? longitude;
  String? address;
  GeocodingModal(
      {this.latitude = 0.0, this.longitude = 0.0, this.address = ''});

  GeocodingModal.fromjson(Map<String, dynamic> json) {
    List<double> coordinates = json['queries'] as List<double>;
    this.latitude = coordinates.first;
    this.longitude = coordinates.last;
    this.address = json['features']['placename'] as String;
  }
}
