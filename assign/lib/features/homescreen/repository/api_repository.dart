// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:assign/core/constants/constant.dart';
import 'package:assign/models/failure.dart';
import 'package:assign/models/song_detail.dart'; // Ensure this is pointing to your Song model
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
final songRepositoryProvider = Provider((ref) => SongRepository());
class SongRepository {
  Future<Either<Failure, List<Song>>> fetchSongs() async {
    try {
      log("Fetching songs");
      final response = await http.get(
        Uri.parse(APIConstants.baseUrl),
        headers: {
          'X-RapidAPI-Key': APIConstants.apiKey,
          'X-RapidAPI-Host': APIConstants.apiHost,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> songJson = jsonDecode(response.body)['data'];
        final songs = songJson.map((json) => Song.fromJson(json)).toList();
        return Right(songs);
      } else {
        // Here you could use more specific error handling
        // For example, parsing the response body to get error details
        return Left(Failure(message: "Failed to load songs"));
      }
    } catch (e) {
      // Catch network errors, parsing errors, etc
      log(e.toString());
      return Left(Failure(message: e.toString()));
    }
  }
}
