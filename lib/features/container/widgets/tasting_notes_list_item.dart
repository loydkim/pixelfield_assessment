import 'package:flutter/material.dart';
import 'package:pixelfield_project/features/container/models/notes_detail.dart';

class TastingNotesListItem extends StatelessWidget {
  final NotesDetail notesDetail;
  const TastingNotesListItem({super.key, required this.notesDetail});

  @override
  Widget build(BuildContext context) {
    // Adjust these colors to match your UI
    const Color panelColor = Color(0xFF101D21);
    const Color textColor = Colors.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tasting notes header
        notesDetail.by == null
            ? Row(
              children: [
                const Text(
                  'Your notes',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(Icons.west, color: textColor),
                const SizedBox(width: 6),
              ],
            )
            : Text(
              'Tasting notes',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        notesDetail.by == null
            ? Container()
            : Text(
              "by ${notesDetail.by!}",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
        const SizedBox(height: 16),
        // Nose
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nose',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...notesDetail.nose.map(
                (e) => Text(e, style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Palate
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Palate',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...notesDetail.palate.map(
                (e) => Text(e, style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Finish
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Finish',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ...notesDetail.finish.map(
                (e) => Text(e, style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
