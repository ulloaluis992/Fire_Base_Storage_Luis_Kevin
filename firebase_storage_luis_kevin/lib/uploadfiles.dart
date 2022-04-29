import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage_luis_kevin/storage_service.dart';
import 'package:flutter/material.dart';


class UploadFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    String finalPath;
    String finalFileName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Images"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                minWidth: 200,
                height: 40.0,
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg']);

                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No file Selected'),
                      ),
                    );
                    return null;
                  }
                  final path = result.files.single.path;
                  final fileName = result.files.single.name;
                  finalPath = path;
                  finalFileName = fileName;
                },
                color: Colors.blueAccent.shade700,
                child: Text('Cargar Archivo',
                    style: TextStyle(color: Colors.white))),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
                minWidth: 200,
                height: 40.0,
                onPressed: () {
                  storage
                      .uploadFile(finalPath, finalFileName)
                      .then((value) => print('Finalizado'));
                },
                color: Colors.blueAccent.shade700,
                child: Text('Subir Archivo',
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
