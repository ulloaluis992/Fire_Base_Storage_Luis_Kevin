import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage_luis_kevin/downloads.dart';
import 'package:firebase_storage_luis_kevin/showimages.dart';
import 'package:firebase_storage_luis_kevin/uploadfiles.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive page',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/upload': (context) => UploadFiles(),
        '/showimages': (context) => ShowImages(),
        '/downloads': (context) => Dowloads(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.green.shade200,
        appBar: AppBar(
            elevation: 0,
            title: Center(
              child: Text("Bienvenido"),
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  minWidth: 200,
                  height: 40.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/upload');
                  },
                  color: Colors.blueAccent.shade700,
                  child: Text('Subir Archivo',
                      style: TextStyle(color: Colors.white))),
              MaterialButton(
                  minWidth: 200,
                  height: 40.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/showimages');
                  },
                  color: Colors.blueAccent.shade700,
                  child: Text('Ver Imagenes',
                      style: TextStyle(color: Colors.white))),
                      MaterialButton(
                  minWidth: 200,
                  height: 40.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/downloads');
                  },
                  color: Colors.blueAccent.shade700,
                  child: Text('Decargar Imagenes',
                      style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}