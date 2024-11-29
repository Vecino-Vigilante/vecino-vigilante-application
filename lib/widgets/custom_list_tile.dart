import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget subtitle;
  final Widget title;
  final Widget? trailing;

  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: leading,
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Setting mainAxisSize to min
            children: [
              title,
              subtitle,
            ],
          ),
        ),
        const SizedBox(width: 16),
        trailing ?? Container()
      ],
    );
  }
}
