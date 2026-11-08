import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';

/// Contract for choosing a photo and keeping it in the cloud.
abstract class AvatarRepository {
  Future<PickedPhoto?> pick();
  Future<String> upload(PickedPhoto photo);
  Future<void> remove(String path);
}
