import 'package:flutter/material.dart';
import 'package:pixelfield_project/features/container/models/history.dart';
import 'package:pixelfield_project/features/container/widgets/history_attachment_placeholder.dart';
import 'package:pixelfield_project/features/container/widgets/history_timeline_indicator.dart';

class HistoryListItem extends StatelessWidget {
  final History history;

  const HistoryListItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    // Adjust your color palette as needed
    const Color cardColor = Color(0xFF101D21); // Dark panel behind content
    const Color bgColor = Color(0xFF0E1C21); // Background color
    const Color attachmentBgColor = Color(0xFF0B1519); // Background color

    return Container(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        // Each item is a row: [TimelineIndicator] [Content]
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Timeline indicator (fixed width for consistent alignment)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SizedBox(width: 40, child: HistoryTimelineIndicator()),
            ),
            const SizedBox(width: 4),
            // Right: The actual content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label
                    Text(
                      history.label,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      history.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      '${history.descriptions[0]}\n${history.descriptions[1]}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    // Attachments
                    Container(
                      color: attachmentBgColor,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Transform.rotate(
                                  angle: 45 * 3.14159 / 180,
                                  child: Icon(
                                    Icons.attach_file,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 4),
                                const Text(
                                  'Attachments',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                // Placeholder squares
                                HistoryAttachmentPlaceholder(
                                  attachment: history.attachments[0],
                                ),
                                const SizedBox(width: 8),
                                HistoryAttachmentPlaceholder(
                                  attachment: history.attachments[1],
                                ),
                                const SizedBox(width: 8),
                                HistoryAttachmentPlaceholder(
                                  attachment: history.attachments[2],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
