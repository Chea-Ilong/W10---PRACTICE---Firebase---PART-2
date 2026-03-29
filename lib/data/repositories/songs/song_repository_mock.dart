// song_repository_mock.dart

import '../../../model/songs/song.dart';
import 'song_repository.dart';

class SongRepositoryMock implements SongRepository {
  final List<Song> _songs = [];

  @override
  Future<List<Song>> fetchSongs({bool forceRefresh = false}) async {
    return Future.delayed(Duration(seconds: 4), () {
      throw _songs;
    });
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    return Future.delayed(Duration(seconds: 4), () {
      return _songs.firstWhere(
        (song) => song.id == id,
        orElse: () => throw Exception("No song with id $id in the database"),
      );
    });
  }

  @override
  Future<void> likeSong(String songId) async {
    return Future.delayed(Duration(seconds: 4), () {
      int index = _songs.indexWhere((song) => song.id == songId);
      if (index != -1) {
        _songs[index] = _songs[index].copyWith(
          numberOfLike: _songs[index].numberOfLike + 1,
        );
      } else {
        throw Exception("No song with id $songId in the database");
      }
    });
  }
}
