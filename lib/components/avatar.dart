import 'package:flutter/material.dart';

import 'package:moviles_auth/theme/app_theme.dart';

/// Round photo of a person, or their initial while there is no photo.
class Avatar extends StatelessWidget {
  final String? url;
  final String name;
  final double size;

  const Avatar({
    super.key,
    required this.url,
    required this.name,
    this.size = 40,
  });

  Widget _initial() {
    return Center(
      child: Text(
        name.isEmpty ? '?' : name[0].toUpperCase(),
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.w700,
          color: AppColors.surface,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final photo = url;
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: photo == null
          ? _initial()
          : Image.network(
              photo,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _initial(),
            ),
    );
  }
}
