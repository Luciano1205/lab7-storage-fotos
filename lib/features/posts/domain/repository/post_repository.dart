import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';
import 'package:moviles_auth/features/posts/domain/entities/post.dart';

/// Contract of everything the wall can ask about posts, likes and their images.
abstract class PostRepository {
  Future<List<Post>> fetchFeed({required int page, required int size});
  Future<List<Post>> fetchMine({int limit = 3});
  Future<void> create(String content, {String? imagePath});
  Future<void> like(String postId);
  Future<void> unlike(String postId);
  Future<PickedPhoto?> pickImage();
  Future<String> uploadImage(PickedPhoto photo);
  Future<String> imageUrl(String path);
}
