// ignore_for_file: depend_on_referenced_packages
import 'package:assign/features/homescreen/screens/song_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:assign/models/song_detail.dart'; // Ensure you have this Song model
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HorizontalRowListViewBuilder extends ConsumerWidget {
  final List<Song> songs;
  final bool isRoundedImage; // Add this line

  const HorizontalRowListViewBuilder({
    Key? key,
    required this.songs,
    this.isRoundedImage = false, // Set to false by default
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      // height: 90, // Adjust based on your row item height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Column(
            children: [
              Container(
                color: Colors.white,
                width: 380, // Adjust based on your content
                margin: const EdgeInsets.symmetric(
                    horizontal: 8), // Spacing between items
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: isRoundedImage
                            ? BorderRadius.circular(10)
                            : BorderRadius
                                .zero, // Use isRoundedImage to adjust borderRadius
                        child: Image.network(
                          song.coverMedium,
                          width: 50, // Fixed width for the image
                          height:
                              50, // Fixed height to match the row height, maintain aspect ratio
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  ));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.title,
                                  style: GoogleFonts.ptSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  song.artistName,
                                  style: GoogleFonts.ptSans(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      !song.liked
                          ? IconButton(
                              icon: const Icon(Icons.favorite),
                              color: const Color.fromRGBO(244, 67, 54,
                                  1), // Change this icon as needed based on whether the song is liked
                              onPressed: () {
                                // ref
                                //     .read(songControllerProvider.notifier)
                                //     .toggleSongLiked(song.title);
                                // Handle like button tap
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons
                                  .favorite_border), // Change this icon as needed based on whether the song is liked
                              onPressed: () {
                                // ref
                                // .read(songControllerProvider.notifier)
                                // .toggleSongLiked(song.title);
                                // Handle like button tap
                              },
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          );
        },
      ),
    );
  }
}
