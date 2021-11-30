import 'package:eds_test/data/models/post.dart';
import 'package:eds_test/data/repositories/post_repo.dart';
import 'package:eds_test/ui/screens/post_screen.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  final int userId;

  const PostsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: PostRepository().userPosts(userId),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView(
                  children: snapshot.data!
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
                ),
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
