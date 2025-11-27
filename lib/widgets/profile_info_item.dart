import 'package:flutter/material.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showEditIcon;
  final VoidCallback? onEditPressed;
  final Color iconColor;

  const ProfileInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showEditIcon = false,
    this.onEditPressed,
    required this.iconColor,
    required TextStyle style,
  });

  @override
  Widget build(BuildContext context) {
    // Gaya teks default sesuai tema. Jika textTheme tidak didefinisikan,
    // fallback ke gaya kosong.
    final TextStyle labelStyle =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    final TextStyle valueStyle =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bagian 1: ikon dan label dengan lebar 1/3 dari total lebar layar.
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              // Gunakan Expanded agar label tidak meluber keluar.
              Expanded(child: Text(label, style: labelStyle)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(value, style: valueStyle)),
              if (showEditIcon)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEditPressed,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
