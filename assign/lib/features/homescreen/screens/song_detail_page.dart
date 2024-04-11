import 'dart:async';
import 'package:assign/core/utils/format_types.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assign/core/constants/colros.dart'; // Make sure this path matches your project structure

class SongDetailPage extends StatefulWidget {
  final String title;
  final String artistName;
  final String albumTitle;
  final String coverMedium;
  final String previewUrl;

  const SongDetailPage({
    Key? key,
    required this.title,
    required this.artistName,
    required this.albumTitle,
    required this.coverMedium,
    required this.previewUrl,
  }) : super(key: key);

  @override
  _SongDetailPageState createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  double _currentVolume = 1.0;
  bool _isMuted = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
        _sliderValue = _position.inSeconds.toDouble();
      });
    });
    _audioPlayer.setVolume(_currentVolume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _audioPlayer.setVolume(_isMuted ? 0 : _currentVolume);
    });
  }

  Future<void> _playAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.previewUrl));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.textColor),
        backgroundColor: AppColors.bgColor,
        title: Text(widget.title,
            style:
                GoogleFonts.ptSans(fontSize: 24, color: AppColors.textColor)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(widget.title,
                style: GoogleFonts.ptSans(
                    fontSize: 22, fontWeight: FontWeight.w600)),
            Text('${widget.artistName} - ${widget.albumTitle}',
                style: GoogleFonts.ptSans(
                    fontSize: 14, color: AppColors.greyColor)),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(widget.coverMedium,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                      onPressed: _toggleMute),
                  Expanded(
                    child: Slider(
                      inactiveColor: Colors.grey,
                      thumbColor: AppColors.textColor,
                      activeColor: AppColors.textColor,
                      value: _currentVolume,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (value) {
                        setState(() {
                          _currentVolume = value;
                          _isMuted = value == 0;
                          _audioPlayer.setVolume(_currentVolume);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: CircleAvatar(
                backgroundColor: AppColors.textColor,
                minRadius: 38,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    key: ValueKey<bool>(_isPlaying),
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                        color: AppColors.bgColor, size: 35),
                    onPressed: _playAudio,
                  ),
                ),
              ),
            ),
            Slider(
              thumbColor: AppColors.textColor,
              inactiveColor: Colors.grey,
              activeColor: AppColors.textColor,
              value: _sliderValue,
              min: 0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (value) async {
                _sliderValue = value;
                final position = Duration(seconds: value.toInt());
                await _audioPlayer.seek(position);
                // Update the playing state accordingly
                if (!_isPlaying) {
                  await _audioPlayer.pause();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(_position)),
                  Text(formatDuration(_duration))
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text("Meri Bhakti  !",
                  style: GoogleFonts.allura(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
