import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EarthquakePage extends StatefulWidget {
  @override
  _EarthquakePageState createState() => _EarthquakePageState();
}

class _EarthquakePageState extends State<EarthquakePage> {
  late VideoPlayerController _earthquakeVideoController;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller for the earthquake video
    _earthquakeVideoController = VideoPlayerController.asset('assets/videos/earthquake_video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Dispose the video controller when done
    _earthquakeVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earthquakes'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the page
            Text(
              'Earthquake Safety Tips',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 16),

            // Safety Tip 1
            Text(
              '1. Drop, Cover, and Hold On.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Find shelter under a sturdy piece of furniture and hold on until the shaking stops.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 16),

            // Safety Tip 2
            Text(
              '2. Stay Away from Windows and Heavy Furniture.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Move away from windows, glass, and anything that might fall or shatter.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 16),

            // Safety Tip 3
            Text(
              '3. Once the Shaking Stops, Move to Open Ground.',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'After the shaking stops, move outdoors or to a safe, open area away from buildings.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff1f597c),
              ),
            ),
            SizedBox(height: 20),

            // Video Section
            if (_earthquakeVideoController.value.isInitialized)
              AspectRatio(
                aspectRatio: _earthquakeVideoController.value.aspectRatio,
                child: VideoPlayer(_earthquakeVideoController),
              ),
            SizedBox(height: 16),

            // Play and Pause Button for Video
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _earthquakeVideoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Color(0xff1f597c),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_earthquakeVideoController.value.isPlaying) {
                        _earthquakeVideoController.pause();
                      } else {
                        _earthquakeVideoController.play();
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
                  SnackBar(content: Text('Earthquake simulation coming soon!')),
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
