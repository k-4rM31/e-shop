import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isCurrentPage;

  const FeedVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.isCurrentPage,
  });

  @override
  State<FeedVideoPlayer> createState() => _FeedVideoPlayerState();
}

class _FeedVideoPlayerState extends State<FeedVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    try {
      await _controller.initialize();
      _controller.setLooping(true);
      if (mounted) {
        setState(() => _isInitialized = true);
        if (widget.isCurrentPage) {
          _controller.play();
        }
      }
    } catch (e) {
      debugPrint('Erreur chargement vidéo: $e');
    }
  }

  @override
  void didUpdateWidget(covariant FeedVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInitialized) {
      if (widget.isCurrentPage && !_controller.value.isPlaying) {
        _controller.play();
      } else if (!widget.isCurrentPage && _controller.value.isPlaying) {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_isInitialized) return;
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white24),
      );
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Maintient le ratio de la vidéo en mode couverture (Aspect Fill)
          FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),

          // Icône de Pause au centre lors du tap
          if (!_controller.value.isPlaying)
            Container(
              color: Colors.black26,
              child: const Center(
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white70,
                  size: 72,
                ),
              ),
            ),
        ],
      ),
    );
  }
}