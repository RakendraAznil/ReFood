import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../utils/app_colors.dart';

class ReFoodMark extends StatelessWidget {
  const ReFoodMark({super.key, this.size = 54});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.autorenew_rounded, size: size, color: AppColors.primary),
          Icon(
            Icons.restaurant,
            size: size * .49,
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}

class AuthBrand extends StatelessWidget {
  const AuthBrand({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!compact) ...[
          const ReFoodMark(size: 54),
          const SizedBox(width: 12),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ReFood',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: compact ? 30 : 28,
              ),
            ),
            const Text(
              'Kenyang Hemat, Bumi Selamat',
              style: TextStyle(
                color: AppColors.textBlack,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (compact) ...[const Spacer(), const ReFoodMark(size: 40)],
      ],
    );
  }
}

class AuthRoleSelector extends StatelessWidget {
  const AuthRoleSelector({
    super.key,
    required this.role,
    required this.onChanged,
  });

  final UserRole role;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: UserRole.values.map((option) {
        final selected = option == role;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: option == UserRole.tenant ? 8 : 0),
            child: OutlinedButton(
              onPressed: () => onChanged(option),
              style: OutlinedButton.styleFrom(
                foregroundColor: selected
                    ? AppColors.primary
                    : AppColors.textGray,
                backgroundColor: selected ? const Color(0xFFE8F8F0) : null,
                side: BorderSide(
                  color: selected ? AppColors.primary : AppColors.softGray,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(option.label),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9B9B9B), fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFAAAAAA))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('atau', style: TextStyle(color: AppColors.textGray)),
        ),
        Expanded(child: Divider(color: Color(0xFFAAAAAA))),
      ],
    );
  }
}

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const CircleAvatar(
        radius: 11,
        backgroundColor: Colors.white,
        child: Text(
          'G',
          style: TextStyle(
            color: Color(0xFF4285F4),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      label: const Text('Daftar dengan akun Google'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Color(0xFF999999)),
        minimumSize: const Size.fromHeight(46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
    );
  }
}
