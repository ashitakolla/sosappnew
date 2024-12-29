// lib/pagestosimulate/cpr_page.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CPRPage extends StatefulWidget {
  @override
  _CPRPageState createState() => _CPRPageState();
}

class _CPRPageState extends State<CPRPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/cpr_video.mp4')
      ..initialize().then((_) {
        setState(() {});  // Update the UI when the video is ready
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();  // Dispose the controller to release resources
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CPR'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CPR Safety Tips',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 16),
            Text(
              '1. Check for responsiveness: Tap and shout to see if the person responds.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '2. Call for help: Dial emergency services immediately.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '3. Start chest compressions: Place hands in the center of the chest and push hard and fast.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '4. Continue CPR until help arrives or the person starts breathing.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '5. If trained, give rescue breaths in addition to chest compressions.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '6. Ensure that the chest fully recoils between compressions.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 16),
            _controller.value.isInitialized
                ? Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
