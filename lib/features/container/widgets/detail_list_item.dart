import 'package:flutter/material.dart';

class DetailListItem extends StatelessWidget {
  final String label;
  final String value;

  const DetailListItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13.0),
      child: Row(
        children: [
          // Label
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // Value
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
