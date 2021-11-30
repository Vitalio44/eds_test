import 'package:eds_test/data/models/comment.dart';
import 'package:eds_test/data/repositories/post_repo.dart';
import 'package:flutter/material.dart';

class CommentForm extends StatelessWidget {
  CommentForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text('New Comment')),
          ),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name *'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email *'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if (!RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
                  .hasMatch(value)) {
                return 'Please enter valid email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _bodyController,
            decoration: const InputDecoration(labelText: 'Comment *'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  PostRepository()
                      .newCommet(
                    Comment(
                      postId: 1,
                      id: 0,
                      name: _nameController.value.text,
                      email: _emailController.value.text,
                      body: _bodyController.value.text,
                    ),
                    false,
                  )
                      .then(
                    (comment) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text('NEW comment ID: ${comment?.id}'),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
