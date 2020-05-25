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

  final Completer<String> googleMapsStyle = Completer();
  final Completer<GoogleMapController> googleMapsController = Completer();
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    rootBundle.loadString("asset/googlemaps.json").then((styles) => googleMapsStyle.complete(styles));
    setupMap();
  }

  void setupMap() async {
    final googlemaps = await googleMapsController.future;
    final styles = await googleMapsStyle.future;

    googlemaps.setMapStyle(styles);

    setState(() {
      markers.add(Marker(
        markerId: MarkerId(initialPosition.target.toString()),
        position: initialPosition.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "From here"),
      ));

      markers.add(Marker(
        markerId: MarkerId(endPosition.target.toString()),
        position: endPosition.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "To here"),
      ));

      polylines.add(Polyline(
        polylineId: PolylineId("path"),
        points: [initialPosition.target, endPosition.target],
        width: 3,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SlidingUpPanel(
        minHeight: 100,
        maxHeight: 300,
        panel: panel(),
        body: map(),
      ),
    );
  }

  Widget panel() => Container(
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.shade300,
              ),
            ),
            transportMedium(imageAsset: "asset/uber-normal.png", name: "UberX", time: "12:00", price: "\$10.50"),
            transportMedium(imageAsset: "asset/uber-pop.jpg", name: "Pool", time: "12:10", price: "\$7.50"),
            Divider(thickness: 1),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Pay at station or at transit services", style: TextStyle(fontSize: 13)),
                  SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {},
                    minWidth: double.infinity,
                    height: 50,
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text("SEE ROUTES"),
                  ),
                ],
              ),
            )
          ],
        ),
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
        trailing: Text(price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      );

  Widget map() => GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: initialPosition,
        polylines: polylines,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          this.googleMapsController.complete(controller);
        },
      );
}
