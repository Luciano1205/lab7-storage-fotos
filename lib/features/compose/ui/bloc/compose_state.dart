import 'package:moviles_auth/features/avatar/domain/entities/picked_photo.dart';

enum ComposeStatus { initial, loading, success, failure }

/// Single state of the compose screen: the attached photo and which moment it is.
class ComposeState {
  final ComposeStatus status;
  final PickedPhoto? photo;
  final String? errorMessage;

  const ComposeState({
    this.status = ComposeStatus.initial,
    this.photo,
    this.errorMessage,
  });

  ComposeState copyWith({
    ComposeStatus? status,
    PickedPhoto? photo,
    bool removePhoto = false,
    String? errorMessage,
  }) {
    return ComposeState(
      status: status ?? this.status,
      photo: removePhoto ? null : photo ?? this.photo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'ComposeState(status: ${status.name}, '
        'photo: ${photo == null ? 'no' : '${photo!.bytes.length} bytes'}, '
        'error: $errorMessage)';
  }
}
