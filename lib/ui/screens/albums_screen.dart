import 'package:eds_test/data/models/album.dart';
import 'package:eds_test/data/repositories/album_repo.dart';
import 'package:eds_test/ui/screens/album_screen.dart';
import 'package:flutter/material.dart';

class AlbumsScreen extends StatelessWidget {
  final int userId;

  const AlbumsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: AlbumRepository().userAlbums(userId),
          builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!
                    .map<Widget>((e) => ListTile(
                          leading: e.thumbnail != null
                              ? Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.network(
                                    e.thumbnail!.thumbnailUrl,
                                  ),
                                )
                              : null,
                          title: Text(e.title),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AlbumScreen(
                                  albumId: e.id,
                                ),
                              ),
                            );
                          },
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
