import 'package:eds_test/data/models/comment.dart';
import 'package:eds_test/data/models/post.dart';
import 'package:eds_test/data/providers/post_api.dart';

class PostRepository {
  final _api = PostApi();

  /// User posts list
  Future<List<Post>> userPosts(int userId) async {
    final data = await _api.rawUserPosts(userId);
    return data != null ? Post.fromList(data) : <Post>[];
  }

  /// Post comments list
  Future<List<Comment>> postCommets(int userId) async {
    final data = await _api.rawPostComments(userId);
    return data != null ? Comment.fromList(data) : <Comment>[];
  }

  /// Create new post comment
  Future<Comment?> newCommet(Comment comment, [bool includeId = true]) async {
    final data = await _api.newPostComment(
      comment.toJson(includeId),
      comment.postId,
    );
    print('--> data');
    print(data);
    return data != null ? Comment.fromJson(data) : null;
  }
}
