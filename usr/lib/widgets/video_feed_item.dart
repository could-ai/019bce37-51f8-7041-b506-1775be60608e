import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/video_post.dart';
import 'action_button.dart';

class VideoFeedItem extends StatefulWidget {
  final VideoPost post;

  const VideoFeedItem({super.key, required this.post});

  @override
  State<VideoFeedItem> createState() => _VideoFeedItemState();
}

class _VideoFeedItemState extends State<VideoFeedItem> with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Video/Image
        GestureDetector(
          onTap: () {
            // Toggle play/pause (mock)
          },
          child: CachedNetworkImage(
            imageUrl: widget.post.videoUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.black,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[900],
              child: const Icon(Icons.error, color: Colors.white),
            ),
          ),
        ),

        // Gradient Overlay for readability
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 0.8, 1.0],
              ),
            ),
          ),
        ),

        // Right Side Actions
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Avatar
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(widget.post.userAvatarUrl),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF0055), // Neon Pink
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Like Button
              ActionButton(
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                label: _isLiked ? '${widget.post.likes + 1}' : '${widget.post.likes}',
                color: _isLiked ? const Color(0xFFFF0055) : Colors.white,
                onTap: _toggleLike,
              ),
              const SizedBox(height: 20),

              // Comment Button
              ActionButton(
                icon: Icons.comment_rounded,
                label: '${widget.post.comments}',
                onTap: () {},
              ),
              const SizedBox(height: 20),

              // Share Button
              ActionButton(
                icon: Icons.share_rounded,
                label: '${widget.post.shares}',
                onTap: () {},
              ),
              const SizedBox(height: 40),

              // Rotating Music Disc
              RotationTransition(
                turns: _animationController,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[800]!, width: 8),
                    image: NetworkImage(widget.post.userAvatarUrl).image,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom Info Area
        Positioned(
          left: 16,
          bottom: 40,
          right: 100, // Leave space for right actions
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '@${widget.post.username}',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [const Shadow(blurRadius: 4, color: Colors.black)],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.post.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.white,
                  shadows: [const Shadow(blurRadius: 2, color: Colors.black)],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: widget.post.tags.map((tag) => Text(
                  '#$tag',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )).toList(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.music_note, size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.post.musicTrackName,
                      style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
