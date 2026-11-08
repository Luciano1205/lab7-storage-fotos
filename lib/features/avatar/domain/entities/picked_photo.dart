import 'dart:typed_data';

/// A photo chosen on the phone: its bytes and its file extension.
class PickedPhoto {
  final Uint8List bytes;
  final String extension;

  const PickedPhoto({required this.bytes, required this.extension});
}
