// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:assign/features/homescreen/screens/song_detail_page.dart';
import 'package:assign/models/song_detail.dart';
import 'package:flutter/material.dart';

class VerticalListViewBuilder extends StatelessWidget {
  final List<Song> songs;
  final int startIndex;

  const VerticalListViewBuilder({
    Key? key,
    required this.songs,
    this.startIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length - startIndex,
      itemBuilder: (context, index) {
        // Adjust index based on startIndex
        final adjustedIndex = index + startIndex;
        final song = songs[adjustedIndex];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongDetailPage(
                  title: song.title,
                  artistName: song.artistName,
                  albumTitle: song.albumTitle,
                  coverMedium: song.coverMedium,
                  previewUrl: song.preview,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.network(
                      song.coverMedium,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(
                      song.title,
                      style: GoogleFonts.ptSans(fontSize: 14),
                    ),
                    subtitle: Text(song.artistName,
                        style: GoogleFonts.ptSans(fontSize: 12)),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors
                          .red, // Change to Icons.favorite for a "liked" state
                      onPressed: () {
                        // Handle the like button tap
                        log('Liked song: ${song.title}');
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        );
      },
    );
  }
}
