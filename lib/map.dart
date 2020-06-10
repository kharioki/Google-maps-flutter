import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map/map_style.json');

    // set style to controller
    _mapController.setMapStyle(style);
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/icons/noodle_icon.png');
  }

  void _setPolygons() {
    List<LatLng> polygonLatLngs = List<LatLng>();

    polygonLatLngs.add(LatLng(-1.283389, 36.817223));
    polygonLatLngs.add(LatLng(-1.286389, 36.807223));
    polygonLatLngs.add(LatLng(-1.289389, 36.803223));
    polygonLatLngs.add(LatLng(-1.289389, 36.813223));

    _polygons.add(
      Polygon(
        polygonId: PolygonId('0'),
        points: polygonLatLngs,
        fillColor: Colors.transparent,
        strokeWidth: 1,
        strokeColor: Colors.purpleAccent,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylineLatLngs = List<LatLng>();

    polylineLatLngs.add(LatLng(-1.253389, 36.817223));
    polylineLatLngs.add(LatLng(-1.256389, 36.807223));
    polylineLatLngs.add(LatLng(-1.259389, 36.803223));
    polylineLatLngs.add(LatLng(-1.259389, 36.813223));
    polylineLatLngs.add(LatLng(-1.253389, 36.817223));

    _polylines.add(
      Polyline(
        polylineId: PolylineId('0'),
        points: polylineLatLngs,
        color: Colors.purpleAccent,
        width: 1,
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
        circleId: CircleId('0'),
        center: LatLng(-1.213389, 36.815223),
        radius: 1000,
        fillColor: Color.fromRGBO(102, 51, 153, .5),
        strokeWidth: 1,
        strokeColor: Colors.purpleAccent,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(-1.286389, 36.817223),
          infoWindow: InfoWindow(
            title: 'Nairobi',
            snippet: 'City under the Sun',
          ),
          icon: _markerIcon,
        ),
      );
    });

    _setMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(-1.286389, 36.817223),
              zoom: 12,
            ),
            markers: _markers,
            polygons: _polygons,
            polylines: _polylines,
            circles: _circles,
            myLocationEnabled: true,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 32),
            child: Text('Kharioki'),
          ),
        ],
      ),
    );
  }
}
