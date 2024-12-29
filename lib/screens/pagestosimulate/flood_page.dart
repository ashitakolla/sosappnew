import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FloodPage extends StatefulWidget {
  @override
  _FloodPageState createState() => _FloodPageState();
}

class _FloodPageState extends State<FloodPage> {
  late VideoPlayerController _floodVideoController;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller for the flood video
    _floodVideoController = VideoPlayerController.asset('assets/videos/flood_video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Dispose the video controller when done
    _floodVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floods'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the page
            Text(
              'Flood Safety Tips',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 16),

            // Safety Tip 1
            Text(
              '1. Move to higher ground immediately.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '2. Avoid driving through flooded areas.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '3. Stay away from floodwater and never walk through it.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '4. If indoors, move to higher floors and avoid basements.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '5. Follow evacuation orders from local authorities.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 20),

            // Video Section
            if (_floodVideoController.value.isInitialized)
              AspectRatio(
                aspectRatio: _floodVideoController.value.aspectRatio,
                child: VideoPlayer(_floodVideoController),
              ),
            SizedBox(height: 16),

            // Play and Pause Button for Video
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _floodVideoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Color(0xff1f597c),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_floodVideoController.value.isPlaying) {
                        _floodVideoController.pause();
                      } else {
                        _floodVideoController.play();
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Simulate Button
            ElevatedButton(
              onPressed: () {
                // Show a message for now since simulation is not implemented
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Flood simulation coming soon!')),
                );
              },
              child: Text('Simulate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffbdd0d6),
                foregroundColor: Color(0xff1f597c),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
