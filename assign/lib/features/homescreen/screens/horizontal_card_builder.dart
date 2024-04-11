// ignore_for_file: depend_on_referenced_packages

import 'package:assign/features/homescreen/screens/song_detail_page.dart';
import 'package:assign/models/song_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HorizontalCardListViewBuilder extends StatelessWidget {
  final List<Song> songs;
  final bool isRoundedImage;

  const HorizontalCardListViewBuilder({
    Key? key,
    required this.songs,
    this.isRoundedImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Adjust based on your layout needs
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Container(
  
            width: 80, // Adjust the width as needed
            margin: const EdgeInsets.symmetric(
                horizontal: 8), // Add some spacing between items
            child: GestureDetector(
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
                  SizedBox(
                    height: 100, // Fixed height for the image
                    width: double
                        .infinity, // Keeps the image width consistent with the container
                    child: ClipRRect(
                      borderRadius: isRoundedImage
                          ? BorderRadius.circular(15)
                          : BorderRadius.zero,
                      child: Image.network(
                        song.coverMedium,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      song.title,
                      style: GoogleFonts.ptSans(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
