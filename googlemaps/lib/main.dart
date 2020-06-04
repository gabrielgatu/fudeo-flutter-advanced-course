import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static final CameraPosition initialPosition = CameraPosition(
    target: LatLng(40.785091, -73.968285),
    tilt: 0,
    bearing: 0,
    zoom: 15,
  );

  static final CameraPosition endPosition = CameraPosition(
    target: LatLng(40.780091, -73.962185),
    tilt: 0,
    bearing: 0,
    zoom: 15,
  );

  final Completer<String> googleMapStyle = Completer();
  final Completer<GoogleMapController> googleMapController = Completer();
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    rootBundle.loadString("asset/googlemaps.json").then((style) => googleMapStyle.complete(style));
    setupMap();
  }

  void setupMap() async {
    final googlemap = await googleMapController.future;
    final style = await googleMapStyle.future;

    googlemap.setMapStyle(style);

    setState(() {
      markers.add(Marker(
        markerId: MarkerId(initialPosition.target.toString()),
        position: initialPosition.target,
        infoWindow: InfoWindow(title: "Starting point"),
      ));

      markers.add(Marker(
        markerId: MarkerId(endPosition.target.toString()),
        position: endPosition.target,
        infoWindow: InfoWindow(title: "End point"),
      ));

      polylines.add(Polyline(
        polylineId: PolylineId(initialPosition.target.toString() + endPosition.target.toString()),
        points: [initialPosition.target, endPosition.target],
        width: 4,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 100,
        maxHeight: 300,
        panel: panel(),
        body: map(),
      ),
    );
  }

  Widget panel() => Column(
        children: [
          Container(
            width: 60,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          transportMedium(imageAsset: "asset/uber-normal.png", name: "UberX", time: "12:05", price: "\$10.50"),
          transportMedium(imageAsset: "asset/uber-pop.jpg", name: "Pool", time: "12:10", price: "\$7.50"),
          Divider(thickness: 1),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Book it now", style: TextStyle(fontSize: 13)),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                height: 50,
                color: Colors.black,
                textColor: Colors.white,
                child: Text("BOOK RIDE"),
              ),
            ]),
          ),
        ],
      );

  Widget transportMedium({
    @required String imageAsset,
    @required String name,
    @required String time,
    @required String price,
  }) =>
      ListTile(
        leading: Image.asset(imageAsset, width: 60),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(time),
        trailing: Text(price),
      );

  Widget map() => GoogleMap(
        initialCameraPosition: initialPosition,
        zoomControlsEnabled: false,
        markers: markers,
        polylines: polylines,
        onMapCreated: (GoogleMapController controller) {
          this.googleMapController.complete(controller);
        },
      );
}
