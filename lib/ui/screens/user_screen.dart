import 'package:eds_test/data/models/address.dart';
import 'package:eds_test/data/models/album.dart';
import 'package:eds_test/data/models/company.dart';
import 'package:eds_test/data/models/post.dart';
import 'package:eds_test/data/models/user.dart';
import 'package:eds_test/data/repositories/album_repo.dart';
import 'package:eds_test/data/repositories/post_repo.dart';
import 'package:eds_test/ui/screens/post_screen.dart';
import 'package:eds_test/ui/screens/posts_screen.dart';
import 'package:flutter/material.dart';

import 'album_screen.dart';
import 'albums_screen.dart';

class UserScreen extends StatelessWidget {
  final User user;
  const UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              ..._userParams(),
              FutureBuilder(
                future: PostRepository().userPosts(user.id),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        const Center(
                          child: Text(
                            'Posts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PostsScreen(
                                  userId: user.id,
                                ),
                              ),
                            );
                          },
                          child: Text('See all ${user.username} posts'),
                        ),
                        ...snapshot.data!
                            .take(3)
                            .map<Widget>((e) => ListTile(
                                  title: Text(e.title),
                                  subtitle: Text(
                                    '${e.body.split('\n').first}...',
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PostScreen(
                                          post: e,
                                        ),
                                      ),
                                    );
                                  },
                                ))
                            .toList(),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: AlbumRepository().userAlbums(user.id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Album>> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        const Center(
                          child: Text(
                            'Albums',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AlbumsScreen(
                                  userId: user.id,
                                ),
                              ),
                            );
                          },
                          child: Text('See all ${user.username} albums'),
                        ),
                        ...snapshot.data!
                            .take(3)
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
                      ],
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _userParams() {
    return user.paramsToList().map((element) {
      if (element is Address) {
        return Column(
          children: [
            const Divider(indent: 10),
            const Text(
              'Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(element.city),
            Text(element.street),
          ],
        );
      } else if (element is Company) {
        return Column(
          children: [
            const Divider(indent: 10),
            const Text(
              'Company',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(element.name),
            Text(element.bs),
            Text(
              element.catchPhrase,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );
      } else {
        return Text(element);
      }
    }).toList();
  }
}
