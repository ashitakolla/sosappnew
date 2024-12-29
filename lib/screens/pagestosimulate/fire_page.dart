import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FirePage extends StatefulWidget {
  @override
  _FirePageState createState() => _FirePageState();
}

class _FirePageState extends State<FirePage> {
  late VideoPlayerController _fireVideoController;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller for the fire safety video
    _fireVideoController = VideoPlayerController.asset('assets/videos/fire_safety.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Dispose the video controller when done
    _fireVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Safety'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the page
            Text(
              'Fire Safety Tips',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 16),

            // Safety Tip 1
            Text(
              '1. Stay alert to fire alarms and evacuation orders.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '2. If you are indoors, stay low to the ground to avoid smoke inhalation.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '3. Keep a fire extinguisher nearby and know how to use it.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '4. Evacuate immediately if there is a fire and do not use elevators.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '5. If trapped indoors, use a cloth to seal the gaps around doors and windows.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '6. Wear protective clothing to minimize burns and heat exposure.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 20),

            // Video Section
            if (_fireVideoController.value.isInitialized)
              AspectRatio(
                aspectRatio: _fireVideoController.value.aspectRatio,
                child: VideoPlayer(_fireVideoController),
              ),
            SizedBox(height: 16),

            // Play and Pause Button for Video
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _fireVideoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Color(0xff1f597c),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_fireVideoController.value.isPlaying) {
                        _fireVideoController.pause();
                      } else {
                        _fireVideoController.play();
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
                  SnackBar(content: Text('Fire simulation coming soon!')),
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
