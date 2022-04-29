import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage_luis_kevin/storage_service.dart';
import 'package:flutter/material.dart';

class ShowImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase IMG'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: storage.listFiles(),
              builder: (BuildContext context,
                  AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 50,
                        width: 350,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child:
                                        Text(snapshot.data.items[index].name)),
                              );
                            }),
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
            FutureBuilder(
              future: storage.dowloadURL('20220428_190730.jpg'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    width: 300,
                    height: 300,
                    child: Image.network(
                      snapshot.data,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.arrow_left_outlined),
                onPressed: () {},
              ),
              label: "Anterior"),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.arrow_right_outlined),
              onPressed: () {},
            ),
            label: "Siguiente",
          )
        ],
      ),
    );
  }
}
