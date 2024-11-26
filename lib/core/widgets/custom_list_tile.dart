import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? customWidget;

  const CustomListTile({super.key, 
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: leading ?? const SizedBox()),
              Expanded(
                flex: title != null || subtitle != null ? 2 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(subtitle ?? '', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: trailing ?? const SizedBox()),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: customWidget,
            ),
          ),

        ],
      ),
    );
  }
}
