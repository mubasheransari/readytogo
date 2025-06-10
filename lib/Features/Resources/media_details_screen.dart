import 'package:flutter/material.dart';
import 'package:readytogo/Constants/constants.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:async';

/*class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/videosample.mp4');

    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowMuting: true,
        allowFullScreen: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blueAccent,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightBlueAccent,
        ),
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Video',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            /*  ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _videoPlayerController.value.isInitialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: Chewie(controller: _chewieController),
                        ),
                        if (!_videoPlayerController.value.isPlaying &&
                            _videoPlayerController.value.position ==
                                Duration.zero)
                          // GestureDetector(
                          //   onTap: () {
                          //     _chewieController.play();
                          //     setState(() {});
                          //   },
                          //   child: Container(
                          //     color: Colors.black38, // semi-transparent overlay
                          //     child: const Icon(
                          //       Icons.play_circle_fill,
                          //       size: 80,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),*/

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _chewieController.play();
                setState(() {});
              },
              child: Center(
                child: GestureDetector(
                  // onTap: _togglePlayPause,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Constants().themeColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Play ▶ ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                "Understanding Chronic Illnesses",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'satoshi'),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/media.png'),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("John Dustin",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'satoshi')),
                      Text("author",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              fontFamily: 'satoshi')),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.thumb_down_alt_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Top Videos from John Justin",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'satoshi'),
              ),
            ),
            const SizedBox(height: 12),
            const VideoCard(
              thumbnail: 'assets/media.png',
              title: 'The Immune System Explained',
              author: 'John Dustin',
              duration: '25 mins',
            ),
            const VideoCard(
              thumbnail: 'assets/media.png',
              title: 'Healthy Eating for a Stronger Body',
              author: 'John Dustin',
              duration: '20 mins',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String author;
  final String duration;

  const VideoCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.author,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            thumbnail,
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontFamily: 'satoshi')),
        subtitle: Text(author),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(duration,
                style:
                    const TextStyle(color: Colors.grey, fontFamily: 'satoshi')),
            const SizedBox(height: 4),
            const Icon(Icons.favorite_border, size: 20),
          ],
        ),
      ),
    );
  }
}*/

/*class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videosample.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {}); // Refresh once initialized
    });

    // Optional: Loop and keep listener
    _controller.setLooping(true);
    _controller.addListener(() {
      setState(() {}); // Keep UI in sync with playback state
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    _ControlsOverlay(
                      controller: _controller,
                      onPlayPauseToggle: _togglePlayPause,
                    ),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                );
              } else {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Understanding Chronic Illnesses",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/media.png'),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("John Dustin",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'satoshi')),
                          Text("author",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  fontFamily: 'satoshi')),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.thumb_down_alt_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Top Videos from John Justin",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'satoshi'),
                  ),
                  const SizedBox(height: 12),
                  const VideoCard(
                    thumbnail: 'assets/media.png',
                    title: 'The Immune System Explained',
                    author: 'John Dustin',
                    duration: '25 mins',
                  ),
                  const VideoCard(
                    thumbnail: 'assets/media.png',
                    title: 'Healthy Eating for a Stronger Body',
                    author: 'John Dustin',
                    duration: '20 mins',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onPlayPauseToggle;

  const _ControlsOverlay({
    super.key,
    required this.controller,
    required this.onPlayPauseToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPauseToggle,
      child: Container(
        color: Colors.black26,
        child: Center(
          child: Icon(
            controller.value.isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_circle_fill,
            color: Colors.white,
            size: 64,
          ),
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String author;
  final String duration;

  const VideoCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.author,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            thumbnail,
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontFamily: 'satoshi')),
        subtitle: Text(author),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(duration,
                style:
                    const TextStyle(color: Colors.grey, fontFamily: 'satoshi')),
            const SizedBox(height: 4),
            const Icon(Icons.favorite_border, size: 20),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/videosample.mp4');

    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowMuting: true,
        allowFullScreen: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blueAccent,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightBlueAccent,
        ),
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Video',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _chewieController.play();
                setState(() {});
              },
              child: Center(
                child: GestureDetector(
                  // onTap: _togglePlayPause,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Constants().themeColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Play ▶ ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // const SizedBox(height: 16),

            // // Play Button (optional: you can remove it if you use center button)
            // Center(
            //   child: GestureDetector(
            //     onTap: _togglePlayPause,
            //     child: Container(
            //       margin: const EdgeInsets.symmetric(horizontal: 40),
            //       width: double.infinity,
            //       height: 45,
            //       decoration: BoxDecoration(
            //         color: Colors.blueAccent,
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           "Play ▶",
            //           style: TextStyle(color: Colors.white, fontSize: 16),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 16),

            // Video Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Understanding Chronic Illnesses",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'satoshi'),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/media.png'),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("John Dustin",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'satoshi')),
                      Text("author",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              fontFamily: 'satoshi')),
                    ],
                  ),
                  const Spacer(),

                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 52,
                      height: 36,
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 52,
                      height: 36,
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 52,
                      height: 36,
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.thumb_down_alt_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // IconButton(
                  //   icon: const Icon(Icons.favorite_border),
                  //   onPressed: () {},
                  // ),
                  // IconButton(
                  //   icon: const Icon(Icons.share_outlined),
                  //   onPressed: () {},
                  // ),
                  // IconButton(
                  //   icon: const Icon(Icons.thumb_down_alt_outlined),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Top Videos Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Top Videos from John Justin",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'satoshi'),
              ),
            ),

            const SizedBox(height: 12),

            const VideoCard(
              thumbnail: 'assets/media.png',
              title: 'The Immune System Explained',
              author: 'John Dustin',
              duration: '25 mins',
            ),
            const VideoCard(
              thumbnail: 'assets/media.png',
              title: 'Healthy Eating for a Stronger Body',
              author: 'John Dustin',
              duration: '20 mins',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String author;
  final String duration;

  const VideoCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.author,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            thumbnail,
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontFamily: 'satoshi')),
        subtitle: Text(author),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(duration,
                style:
                    const TextStyle(color: Colors.grey, fontFamily: 'satoshi')),
            const SizedBox(height: 4),
            const Icon(Icons.favorite_border, size: 20),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

/*class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/videosample.mp4');

    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowMuting: true,
        allowFullScreen: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blueAccent,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightBlueAccent,
        ),
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: Chewie(controller: _chewieController),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _chewieController.play();
                  setState(() {});
                },
                child: Center(
                  child: GestureDetector(
                    // onTap: _togglePlayPause,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Constants().themeColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Play ▶ ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Video Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Understanding Chronic Illnesses",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Author Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                          'https://i.ibb.co/GJ7x0R5/author.jpg'), // Replace with real image
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("John Dustin",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("author",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.thumb_down_alt_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Top Videos Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Top Videos from John Justin",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),

              // Video Cards
              const VideoCard(
                thumbnail:
                    'https://i.ibb.co/DKxKVm8/immune.jpg', // Replace with asset or other image
                title: 'The Immune System Explained',
                author: 'John Dustin',
                duration: '25 mins',
              ),
              const VideoCard(
                thumbnail:
                    'https://i.ibb.co/vvW3DLW/healthy.jpg', // Replace with asset or other image
                title: 'Healthy Eating for a Stronger Body',
                author: 'John Dustin',
                duration: '20 mins',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String author;
  final String duration;

  const VideoCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.author,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(thumbnail,
              width: 55, height: 55, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(author),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(duration, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            const Icon(Icons.favorite_border, size: 20),
          ],
        ),
      ),
    );
  }
}
*/