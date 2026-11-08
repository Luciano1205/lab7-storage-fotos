import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';

/// The only file that talks to the avatars bucket of Supabase Storage.
class SupabaseAvatarDataSource {
  static const bucket = 'avatars';

  Future<String> upload(PickedPhoto photo) async {
    throw UnimplementedError();
  }

  Future<void> remove(String path) async {
    throw UnimplementedError();
  }
}
