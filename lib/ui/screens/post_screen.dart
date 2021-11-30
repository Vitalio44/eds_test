import 'package:eds_test/data/models/comment.dart';
import 'package:eds_test/data/models/post.dart';
import 'package:eds_test/data/repositories/post_repo.dart';
import 'package:eds_test/ui/widgets/add_comment_btn.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final Post post;

  const PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Title: ${post.title}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Body: ${post.body}'),
            const SizedBox(height: 10),
            const Text(
              'Comments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            FutureBuilder(
              future: PostRepository().postCommets(post.id),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Comment>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 10),
                        ...snapshot.data!
                            .map<Widget>((e) => ListTile(
                                  title: Text(e.name),
                                  subtitle: Text(e.body),
                                  onTap: () {},
                                ))
                            .toList(),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const AddCommentBtn(),
          ],
        ),
      ),
    );
  }
}
