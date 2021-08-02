import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import "package:latlong2/latlong.dart";
import 'package:mappy/blocs/geocoding.bloc.dart';
import 'package:mappy/blocs/geocoding.event.dart';
import 'package:mappy/utils/location_helper.dart';

import 'blocs/geocoding.state.dart';

void main() {
  runApp(
    BlocProvider<GeocodingBloc>(
      create: (context) => GeocodingBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: acquireCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            print(snapshot.data!.latitude);
            return FlutterMap(
              options: MapOptions(
                onTap: (snapshot) {
                  BlocProvider.of<GeocodingBloc>(context)
                    ..add(
                      RequestGeocodingEvent(
                          snapshot.latitude, snapshot.longitude),
                    );
                  _setupBottomModalSheet(context);
                },
                center:
                    LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "xxx",
                    additionalOptions: {
                      'accessToken':
                          'xxx',
                      'id': 'xxx',
                    }),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                      builder: (ctx) => Container(
                        child: IconButton(
                          icon: Icon(Icons.location_on),
                          onPressed: null,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _setupBottomModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return BlocBuilder<GeocodingBloc, GeocodingState>(
            builder: (BuildContext contxt, GeocodingState state) {
              if (state is LoadingGeocodingState) {
                return Container(
                  height: 150,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is SuccesfulGeocodingState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      ListTile(
                        title: Text('coordinates'),
                        subtitle: Text(
                            '${state.data.latitude},${state.data.longitude}'),
                      ),
                      ListTile(
                        title: Text('Address'),
                        subtitle: Text(state.data.address!),
                      ),
                    ],
                  ),
                );
              } else if (state is FailGeocodingState) {
                return ListTile(
                  title: Text('error'),
                );
              } else {
                return ListTile(
                  title: Text('Ppa'),
                );
              }
            },
          );
        });
  }
}
