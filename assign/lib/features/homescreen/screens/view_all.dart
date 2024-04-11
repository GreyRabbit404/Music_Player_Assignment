import 'package:assign/core/constants/colros.dart';
import 'package:assign/features/homescreen/screens/vertical_builder.dart';
import 'package:assign/models/song_detail.dart';
import 'package:flutter/material.dart';

class ViewAllScreen extends StatelessWidget {
  final List<Song> songs;
  const ViewAllScreen({required this.songs, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          iconTheme: IconThemeData(color: AppColors.textColor),
          title: Text(
            'View All',
            style: TextStyle(color: AppColors.textColor),
          )),
      backgroundColor: AppColors.bgColor,
      body: VerticalListViewBuilder(songs: songs),
    );
  }
}
