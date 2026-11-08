import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';
import 'package:moviles_auth/features/posts/data/source/supabase_post_data_source.dart';
import 'package:moviles_auth/features/posts/domain/entities/post.dart';
import 'package:moviles_auth/features/posts/domain/repository/post_repository.dart';

/// Fulfils PostRepository with the posts table, the phone and the post-images bucket.
class PostRepositoryImpl implements PostRepository {
  final SupabasePostDataSource _dataSource = SupabasePostDataSource();

  @override
  Future<List<Post>> fetchFeed({required int page, required int size}) {
    return _dataSource.fetchFeed(page: page, size: size);
  }

  @override
  Future<List<Post>> fetchMine({int limit = 3}) {
    return _dataSource.fetchMine(limit: limit);
  }

  @override
  Future<void> create(String content, {String? imagePath}) {
    return _dataSource.create(content, imagePath: imagePath);
  }

  @override
  Future<void> like(String postId) {
    return _dataSource.like(postId);
  }

  @override
  Future<void> unlike(String postId) {
    return _dataSource.unlike(postId);
  }

  @override
  Future<PickedPhoto?> pickImage() async {
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImage(PickedPhoto photo) async {
    throw UnimplementedError();
  }

  @override
  Future<String> imageUrl(String path) async {
    throw UnimplementedError();
  }
}
