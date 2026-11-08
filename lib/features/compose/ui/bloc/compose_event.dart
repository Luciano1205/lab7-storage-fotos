/// Something the compose screen asks the ComposeBloc to do.
abstract class ComposeEvent {}

/// The user wants to attach a photo from the gallery.
class ComposePhotoRequested extends ComposeEvent {
  @override
  String toString() {
    return 'ComposePhotoRequested()';
  }
}

/// The user removed the attached photo.
class ComposePhotoRemoved extends ComposeEvent {
  @override
  String toString() {
    return 'ComposePhotoRemoved()';
  }
}

/// The user pressed Publicar with this text.
class ComposeSubmitted extends ComposeEvent {
  final String content;

  ComposeSubmitted(this.content);

  @override
  String toString() {
    return "ComposeSubmitted('$content')";
  }
}
