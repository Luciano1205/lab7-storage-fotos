import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';

/// The only file that talks to the post-images bucket of Supabase Storage.
class SupabasePostImageDataSource {
  static const bucket = 'post-images';

  Future<String> upload(PickedPhoto photo) async {
    throw UnimplementedError();
  }

  Future<String> signedUrl(String path) async {
    throw UnimplementedError();
  }
}
