import 'package:flutter/material.dart';

import 'comment_form.dart';

class AddCommentBtn extends StatelessWidget {
  const AddCommentBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Add comment'),
      onPressed: () {
        Scaffold.of(context).showBottomSheet<void>(
          (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 200,
                color: Colors.white,
                child: CommentForm(),
              ),
            );
          },
        );
      },
    );
  }
}
