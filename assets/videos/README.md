# Video Assets

## Welcome Screen Background Video

To add a background video to the welcome screen:

1. Add your video file (MP4 format recommended) to this directory
   - Example: `workout_intro.mp4`

2. Update `pubspec.yaml` to ensure assets are included:
   ```yaml
   assets:
     - assets/videos/
   ```

3. Modify `lib/screens/onboarding/welcome_screen.dart` to use VideoPlayer:

```dart
import 'package:video_player/video_player.dart';

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
      'assets/videos/workout_intro.mp4',
    )..initialize().then((_) {
        _videoController.play();
        _videoController.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_videoController.value.isInitialized)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            ),
          ),
        // Dark overlay
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        // Rest of your content...
      ],
    );
  }
}
```

## Video Recommendations

- **Format**: MP4 (H.264 codec)
- **Duration**: 10-30 seconds (for loop)
- **Resolution**: 1080p (1920x1080)
- **File Size**: Keep under 5MB for optimal app size
- **Content Ideas**:
  - Workout montage
  - Fitness lifestyle clips
  - Motivational scenes
  - Gym equipment close-ups
  - Athletes training

## Free Video Resources

- [Pexels Videos](https://www.pexels.com/videos/)
- [Pixabay Videos](https://pixabay.com/videos/)
- [Coverr](https://coverr.co/)
- [Mixkit](https://mixkit.co/free-stock-video/)

## Current Implementation

The welcome screen currently uses an **animated gradient background** with floating orbs instead of a video. This provides:
- Smaller app size
- Better performance
- No loading time
- Theme-aware design

You can keep this implementation or replace it with a video as shown above.
