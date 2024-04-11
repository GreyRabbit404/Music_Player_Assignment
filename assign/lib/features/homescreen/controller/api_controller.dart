// ignore_for_file: depend_on_referenced_packages

import 'package:assign/core/snackbar.dart';
import 'package:assign/features/homescreen/repository/api_repository.dart';
import 'package:assign/models/song_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Ensure this points to your Song model
final songsProvider = StateProvider<List<Song>?>((ref) {
  return null;
});
// SongController Provider
final songControllerProvider =
    StateNotifierProvider<SongController, bool>((ref) {
  return SongController(ref.watch(songRepositoryProvider), ref);
});

// SongController class
class SongController extends StateNotifier<bool> {
  final SongRepository _songRepository;
  final Ref _ref;
  SongController(this._songRepository, this._ref) : super(false);

  Future<void> fetchSongs(BuildContext context) async {
    state = true;
    final result = await _songRepository.fetchSongs();
    result.fold((l) => showSnackBar(context, l.message), (listsongs) {
      showSnackBar(context, "Songs Fetched");
      _ref.read(songsProvider.notifier).update((state) => listsongs);
    });
    // Update the state based on the result
    state = false;
  }

  // Method to toggle liked status for a song
  void toggleSongLiked(String title) {
    _ref.read(songsProvider.notifier).update((state) {
      for (var i in state!) {
        if (i.title == title) {
          i.copyWith(liked: !i.liked);
        }
      }
      return null;
    });
  }
}
