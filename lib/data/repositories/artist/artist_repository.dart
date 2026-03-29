import '../../../model/artist/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists({bool forceRefresh = false});

  Future<Artist?> fetchArtistById(String id);
}
