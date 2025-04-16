import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pixelfield_project/core/constatns/db_key.dart';
import 'package:pixelfield_project/features/container/models/attachment.dart';
import 'package:pixelfield_project/features/container/models/detail.dart';
import 'package:pixelfield_project/features/container/models/history.dart';
import 'package:pixelfield_project/features/container/models/notes_detail.dart';
import 'package:pixelfield_project/features/container/models/tasting_notes.dart';
import 'package:pixelfield_project/features/my_collection/model/my_collection.dart';

class DbInit {
  static initHive() async {
    // Initialize Hive and register the adapter.
    await Hive.initFlutter();
    Hive.registerAdapter(MyCollectionAdapter());
    Hive.registerAdapter(DetailAdapter());
    Hive.registerAdapter(NotesDetailAdapter());
    Hive.registerAdapter(TastingNotesAdapter());
    Hive.registerAdapter(AttachmentAdapter());
    Hive.registerAdapter(HistoryAdapter());

    // Open the box where objects will be stored.
    await Hive.openBox<MyCollection>(myCollectionKey);
    await Hive.openBox<Detail>(detailKey);
    await Hive.openBox<NotesDetail>(notesDetailKey);
    await Hive.openBox<TastingNotes>(tastingNotesKey);
    await Hive.openBox<Attachment>(attachmentKey);
    await Hive.openBox<History>(historyKey);
  }
}
