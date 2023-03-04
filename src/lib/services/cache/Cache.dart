import 'package:src/model/Note.dart';
import 'package:src/services/logger/Logger.dart';

import '../api/ApiService.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();

  factory CacheService() {
    return _instance;
  }

  CacheService._internal();

  Map<String, Note> cachedNotes = {};

  Future<Note> getNote(String id) async{
    Logger().startLogThread("Get note $id");
    if (cachedNotes.containsKey(id)){
      Logger().stopLogThread("Get note $id from cache");
      return cachedNotes[id]!;
    }else{
      Logger().stopLogThread("Get note $id from API");
      Note note = await ApiService().getNote(id);
      cachedNotes[id] = note;
      return note;
    }
  }
}