import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'week-8-practice-53f43-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(String songId) async {
    //new uri for getting current song data
    Uri songUri = Uri.https(
      'week-8-practice-53f43-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/$songId.json',
    );

    final response = await http.get(songUri);
    if (response.statusCode == 200 && response.body != 'null') {
      Map<String, dynamic> songJson = json.decode(response.body);
      int currentLikes = songJson[SongDto.numberOfLikeKey] ?? 0;

      //update the number of like by 1 in the database
      final patchResponse = await http.patch(
        songUri,
        body: json.encode({SongDto.numberOfLikeKey: currentLikes + 1}),
      );
      if (patchResponse.statusCode != 200) {
        throw Exception('fail to like a song');
      }
    } else {
      throw Exception('Song with id $songId not found');
    }
  }
}
