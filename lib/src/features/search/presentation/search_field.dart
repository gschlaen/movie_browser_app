import 'package:flutter/material.dart';
import 'package:movie_browser_app/design_system/foundations.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  final Widget? suffixIcon;

  const SearchField({
    super.key,
    this.onChanged,
    this.hintText = '',
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: AppTypography.bodyLarge,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        hintText: hintText,
        hintStyle: AppTypography.bodyLarge.copyWith(color: AppColors.inactive),
        suffixIcon: suffixIcon,
        prefixIconColor: AppColors.inactive,
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
