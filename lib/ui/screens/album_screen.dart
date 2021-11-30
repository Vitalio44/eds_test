import 'package:eds_test/data/models/photo.dart';
import 'package:eds_test/data/repositories/photo_repo.dart';
import 'package:flutter/material.dart';

class AlbumScreen extends StatelessWidget {
  final int albumId;

  const AlbumScreen({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album $albumId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: PhotoRepository().albumPhotos(albumId),
          builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
            if (snapshot.hasData) {
              return PageView(
                controller: PageController(
                  viewportFraction: 0.85,
                ),
                children: snapshot.data!
                    .map((e) => Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(e.url),
                            ),
                          ),
                          child: Text(e.title),
                        ))
                    .toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
