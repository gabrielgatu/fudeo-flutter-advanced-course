import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors/sensors.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final messageImageUrl =
      "https://images.unsplash.com/photo-1591264135433-9572cf016ca6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80";
  final imagePicker = ImagePicker();
  List<String> photos = [];
  bool privacyMode = false;

  @override
  void initState() {
    super.initState();
    onStartListeningToGyro();
  }

  void onStartListeningToGyro() async {
    gyroscopeEvents.listen((GyroscopeEvent event) async {
      if (event.y.abs() > 8) {
        setState(() {
          privacyMode = true;
        });

        await Future.delayed(Duration(seconds: 5));
        setState(() {
          privacyMode = false;
        });
      }
    });
  }

  void onCallClicked() async {
    final url = "tel:+1 555 010 999";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void onMailClicked() async {
    final userEmail = "jerome@gmail.com";
    final subject = "Hey Jerome";
    final body = "What's up man!";
    final url = "mailto:$userEmail?subject=$subject&body=$body";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void onLinkClicked(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void onAddPhotoClick() async {
    if (await Permission.camera.request().isGranted) {
      final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
      if (pickedFile == null) return;
      setState(() {
        photos.add(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() => AppBar(
        leading: Center(
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Jerome"),
            Text("Active now", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: onCallClicked,
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: onMailClicked,
            icon: Icon(Icons.email),
          ),
        ],
      );

  Widget body() => Column(
        children: <Widget>[
          privacyMode ? privacyModePlaceholder() : messagesList(),
          chatInputs(),
        ],
      );

  Widget messagesList() => Expanded(
          child: ListView.builder(
        reverse: true,
        itemCount: photos.length,
        itemBuilder: (context, index) => message(photos[index]),
      ));

  Widget privacyModePlaceholder() => Expanded(
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Icon(Icons.warning, size: 50, color: Colors.white24),
            SizedBox(height: 10),
            Text("Privacy mode ON", style: TextStyle(fontSize: 16, color: Colors.white24, fontWeight: FontWeight.bold)),
          ]),
        ),
      );

  Widget chatInputs() => Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            chatTextField(),
            SizedBox(width: 20),
            chatPhotoFab(),
          ],
        ),
      );

  Widget chatTextField() => Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(30), boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(150), offset: Offset(0, 0), blurRadius: 10, spreadRadius: 3),
          ]),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Say something nice",
              border: InputBorder.none,
            ),
          )));

  Widget chatPhotoFab() => FloatingActionButton(
        onPressed: onAddPhotoClick,
        backgroundColor: Colors.white,
        child: Icon(Icons.camera_alt),
      );

  Widget message(String localPhotoPath) => Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => onLinkClicked(messageImageUrl),
          child: Column(
            children: <Widget>[
              Container(
                width: 250,
                height: 200,
                margin: EdgeInsets.only(right: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(localPhotoPath),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(150), offset: Offset(-3, -3), blurRadius: 10, spreadRadius: 3),
                    ]),
              ),
            ],
          ),
        ),
      );
}
