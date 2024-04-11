// ignore_for_file: depend_on_referenced_packages

import 'package:assign/core/constants/colros.dart';
import 'package:assign/core/utils/components/custom_drawer.dart';
import 'package:assign/core/utils/components/custom_text_widget.dart';
import 'package:assign/features/data/drawer_data.dart';
import 'package:assign/features/homescreen/controller/api_controller.dart';
import 'package:assign/features/homescreen/screens/horizontal_card_builder.dart';
import 'package:assign/features/homescreen/screens/horizontal_row_builder.dart';
import 'package:assign/features/homescreen/screens/vertical_builder.dart';
import 'package:assign/features/homescreen/screens/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import other necessary packages
import 'package:google_fonts/google_fonts.dart';

class MyScrollablePage extends ConsumerWidget {
  const MyScrollablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(songControllerProvider);
    final songs = ref.watch(songsProvider);

    // Trigger fetching songs if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (songs == null) {
        ref.read(songControllerProvider.notifier).fetchSongs(context);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.textColor),
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: Colors.teal.shade100,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Text(
              'Meri Bhakti',
              style:
                  GoogleFonts.ptSans(fontSize: 20, color: AppColors.textColor),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 6),
            padding: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.textColor, width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.monetization_on, color: AppColors.textColor),
                const SizedBox(width: 2),
                Text('100', style: TextStyle(color: AppColors.textColor)),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ],
      ),
      // drawerScrimColor: AppColors.textColor,
      drawer: CustomDrawer(drawerTitle: 'Menu', items: actionsList),
      body: isLoading || songs == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Listen To Your Favourite Vani !!!',
                    style: TextStyle(color: AppColors.textColor, fontSize: 17),
                  ),
                )),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    text: 'Your God',
                    color: AppColors.greyColor,
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                      height: 150,
                      child: HorizontalCardListViewBuilder(
                        songs: songs, // Your List<Song>
                        isRoundedImage:
                            true, // or false, depending on your needs
                      )),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: 'My PlayList',
                        color: AppColors.greyColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllScreen(songs: songs),
                              ));
                        },
                        child: CustomTextWidget(
                          text: 'View All',
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: HorizontalRowListViewBuilder(
                      isRoundedImage: true,
                      songs: songs,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: HorizontalRowListViewBuilder(
                      isRoundedImage: true,
                      songs: songs,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Power',
                        style: GoogleFonts.ptSans(
                            fontSize: 18, color: AppColors.textColor),
                      ),
                      CustomTextWidget(
                        text: 'ful Mantras',
                        color: AppColors.greyColor,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 150,
                    child: HorizontalCardListViewBuilder(
                      isRoundedImage: false,
                      songs: songs,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: 'Sweet Melody',
                        color: AppColors.greyColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllScreen(songs: songs),
                              ));
                        },
                        child: CustomTextWidget(
                          text: 'View All',
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 230,
                    child: VerticalListViewBuilder(
                      songs: songs,
                      startIndex: 3,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: 'Trending Bhajan',
                        color: AppColors.greyColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllScreen(songs: songs),
                              ));
                        },
                        child: CustomTextWidget(
                          text: 'View All',
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 150,
                    child: HorizontalCardListViewBuilder(
                      isRoundedImage: false,
                      songs: songs,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextWidget(
                    text: 'Trending Alarms and Ringtones',
                    color: AppColors.greyColor,
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: HorizontalRowListViewBuilder(
                      isRoundedImage: true,
                      songs: songs,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: HorizontalRowListViewBuilder(
                      isRoundedImage: true,
                      songs: songs,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: HorizontalRowListViewBuilder(
                      isRoundedImage: true,
                      songs: songs,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Famo',
                        style: GoogleFonts.ptSans(
                            fontSize: 18, color: AppColors.textColor),
                      ),
                      CustomTextWidget(
                        text: 'us Songs',
                        color: AppColors.greyColor,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: HorizontalRowListViewBuilder(
                      isRoundedImage: true,
                      songs: songs,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: HorizontalRowListViewBuilder(
                      songs: songs,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
