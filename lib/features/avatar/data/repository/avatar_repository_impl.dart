import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';
import 'package:moviles_auth/features/avatar/domain/repository/avatar_repository.dart';

/// Fulfils AvatarRepository with the phone for picking and Storage for keeping.
class AvatarRepositoryImpl implements AvatarRepository {
  @override
  Future<PickedPhoto?> pick() async {
    throw UnimplementedError();
  }

  @override
  Future<String> upload(PickedPhoto photo) async {
    throw UnimplementedError();
  }

  @override
  Future<void> remove(String path) async {
    throw UnimplementedError();
  }
}
