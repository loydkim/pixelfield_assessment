// A simple white container for attachments
import 'package:flutter/material.dart';
import 'package:pixelfield_project/features/container/models/attachment.dart';

class HistoryAttachmentPlaceholder extends StatelessWidget {
  final Attachment attachment;
  const HistoryAttachmentPlaceholder({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey.shade400,
      // You could put an Image or Icon here instead of a solid color
    );
  }
}
