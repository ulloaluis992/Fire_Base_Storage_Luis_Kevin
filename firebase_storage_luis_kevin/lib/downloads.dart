
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';



class Dowloads extends StatefulWidget {
  const Dowloads({Key key}) : super(key: key);

  @override
  State<Dowloads> createState() => _Dowloads();
}

class _Dowloads extends State<Dowloads> {
 
   Future<ListResult> listaArchivos;

  @override
  void initState() {
    super.initState();
    listaArchivos = FirebaseStorage.instance.ref('/test').listAll();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Storage'),
        ),
        body: FutureBuilder<ListResult>(
            future: listaArchivos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final  archivos = snapshot.data.items;
                return ListView.builder(
                  itemCount: archivos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final file = archivos[index];
                    return ListTile(
                      title: Text(file.name),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.download_outlined,
                          color: Colors.black,
                        ), // Icon
                        onPressed: () => descargarArchivo(file),
                      ),
                    );
                  },
                )
                    ;
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Ocurrio un error'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future descargarArchivo(Reference ref) async {
    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    
    await Dio().download(url, path);
    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path);
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ref.name)),
    );
  }
}