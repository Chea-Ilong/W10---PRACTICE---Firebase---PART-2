import '../../../model/songs/song.dart';

abstract class SongRepository {
  Future<List<Song>> fetchSongs({bool forceRefresh = false});

  Future<Song?> fetchSongById(String id);

  Future<void> likeSong(String songId);
}
