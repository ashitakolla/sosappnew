import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChokingPage extends StatefulWidget {
  @override
  _ChokingPageState createState() => _ChokingPageState();
}

class _ChokingPageState extends State<ChokingPage> {
  late VideoPlayerController _babyChokingController;
  late VideoPlayerController _adultChokingController;
  late VideoPlayerController _currentController;

  @override
  void initState() {
    super.initState();
    // Initialize both video controllers
    _babyChokingController = VideoPlayerController.asset('assets/videos/baby_choking.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _adultChokingController = VideoPlayerController.asset('assets/videos/adult_choking.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _currentController = _babyChokingController;  // Default to baby choking video
  }

  @override
  void dispose() {
    // Dispose controllers when the page is disposed
    _babyChokingController.dispose();
    _adultChokingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choking First Aid'),
        backgroundColor: Color(0xff1f597c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choking First Aid Tips',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 16),
            Text(
              '1. Encourage the person to cough if they are able to.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '2. If they cannot cough, administer back blows: Stand behind them, bend them forward, and deliver 5 back blows.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '3. If the object is still obstructing the airway, give 5 abdominal thrusts (Heimlich maneuver).',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 8),
            Text(
              '4. Repeat back blows and abdominal thrusts until the object is expelled or the person becomes unconscious.',
              style: TextStyle(fontSize: 18, color: Color(0xff1f597c)),
            ),
            SizedBox(height: 16),
            // Video Player Section
            if (_currentController.value.isInitialized) 
              AspectRatio(
                aspectRatio: _currentController.value.aspectRatio,
                child: VideoPlayer(_currentController),
              ),
            SizedBox(height: 16),
            // Buttons to switch between baby and adult choking videos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentController = _babyChokingController;
                      _currentController.play();
                    });
                  },
                  child: Text('Baby Choking'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentController = _adultChokingController;
                      _currentController.play();
                    });
                  },
                  child: Text('Adult Choking'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
