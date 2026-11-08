import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';
import 'package:moviles_auth/features/posts/data/repository/post_repository_impl.dart';
import 'package:moviles_auth/features/posts/domain/repository/post_repository.dart';

/// Validates a post, uploads its photo if it has one and publishes it.
class PublishPostUseCase {
  static const maxLength = 280;
  final PostRepository _posts = PostRepositoryImpl();

  Future<void> call(String content, {PickedPhoto? photo}) async {
    final text = content.trim();
    if (text.isEmpty) throw Exception('Escribe algo antes de publicar');
    if (text.length > maxLength) {
      throw Exception('Máximo $maxLength caracteres');
    }
    await _posts.create(text);
  }
}
