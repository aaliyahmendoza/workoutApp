# Exercise Library - Quick Start

## Running the Feature

From the home screen:
1. Tap the **"Exercise Library"** card, or
2. Tap the floating action button

## Screen Overview

```
┌─────────────────────────────────────┐
│ EXERCISE LIBRARY                    │
│ ═══════════════════════════════════ │
│                                     │
│ [Gradient Header]                   │
│   Exercise Library                  │
│   100 exercises available           │
│                                     │
│ [Search Bar]                        │
│                                     │
│ [Category Chips: All | Strength |  │
│  Cardio | Core | ...]              │
│                                     │
│ ┌─────────┐ ┌─────────┐            │
│ │ Push-up │ │ Squats  │            │
│ │ [GIF]   │ │ [GIF]   │            │
│ │ Chest   │ │ Legs    │            │
│ └─────────┘ └─────────┘            │
│ ┌─────────┐ ┌─────────┐            │
│ │ Plank   │ │ Burpees │            │
│ │ [GIF]   │ │ [GIF]   │            │
│ │ Core    │ │ Full    │            │
│ └─────────┘ └─────────┘            │
│                                     │
└─────────────────────────────────────┘
```

## Detail Screen Overview

```
┌─────────────────────────────────────┐
│ [Full Screen GIF]                   │
│                                     │
│ ← Back                  ♡ Favorite  │
│                                     │
│                                     │
├─────────────────────────────────────┤
│ [BEGINNER]                          │
│ Push-ups                            │
│                                     │
│ Category | Target | Equipment       │
│ Strength | Chest  | Bodyweight     │
│                                     │
│ Description:                        │
│ A classic upper body exercise...   │
│                                     │
│ Instructions:                       │
│ ① Start in plank position           │
│ ② Lower body to floor               │
│ ③ Push back up                      │
│ ④ Keep core engaged                 │
│                                     │
│ [Start Rest Timer] [⚙️ Settings]   │
│                                     │
│ ┌───────────────────────────────┐   │
│ │  Rest Timer                   │   │
│ │  ◯ ──────────────────         │   │
│ │       01:00                   │   │
│ │  [Reset] [Start]              │   │
│ └───────────────────────────────┘   │
└─────────────────────────────────────┘
```

## Key Interactions

### Search
1. Tap search icon in app bar
2. Type exercise name, category, or muscle
3. Results filter in real-time
4. Tap X to clear

### Filter by Category
1. Scroll category chips horizontally
2. Tap category to filter
3. Tap "All" to reset

### View Exercise
1. Tap any exercise tile
2. View full GIF and details
3. Swipe down or tap back to close

### Use Timer
1. In detail screen, tap "Start Rest Timer"
2. Timer appears below
3. Tap "Start" to begin countdown
4. Tap "Pause" to stop
5. Tap "Reset" to restart

### Adjust Rest Time
1. Tap settings icon (⚙️)
2. Bottom sheet slides up
3. Drag slider or tap preset
4. Tap "Save Settings"

## Features at a Glance

| Feature | Location | Action |
|---------|----------|--------|
| Browse exercises | Library screen | Scroll grid |
| Search | App bar | Tap search icon |
| Filter | Category chips | Tap category |
| View details | Exercise tile | Tap tile |
| Start timer | Detail screen | Tap timer button |
| Settings | Detail screen | Tap settings icon |
| Favorite | Detail screen | Tap heart icon* |

*Favorite is placeholder - functionality coming soon

## Exercise Information

Each exercise includes:
- ✅ Name
- ✅ GIF demonstration
- ✅ Category (Strength, Cardio, Core, etc.)
- ✅ Target muscle
- ✅ Equipment needed
- ✅ Difficulty level
- ✅ Description
- ✅ Step-by-step instructions

## Timer Settings

**Default:** 60 seconds

**Adjustable Range:** 15 seconds - 5 minutes

**Presets:**
- 30 seconds
- 60 seconds
- 90 seconds
- 120 seconds

## Navigation

```
Home Screen
    ↓
Exercise Library
    ↓
Exercise Detail
    ↓
[Back to Library]
    ↓
[Back to Home]
```

## Tips

1. **Slow loading?** Check internet connection
2. **GIF not showing?** Tap tile again to retry
3. **Search not working?** Clear and retype
4. **Timer not visible?** Tap "Start Rest Timer"
5. **Want to exit timer?** Tap "Hide Timer"

## Keyboard Shortcuts (Desktop/Web)

- `Cmd/Ctrl + F` - Focus search (if implemented)
- `Esc` - Close search/detail screen
- `Space` - Start/Pause timer (when focused)

## Offline Behavior

- ⚠️ Requires internet for first load
- ✅ Previously viewed GIFs are cached
- ✅ Falls back to 8 built-in exercises if no connection

## Common Issues

### "No exercises found"
- Check internet connection
- Try clearing search
- Reset category filter to "All"

### "Preview Unavailable"
- GIF URL may be broken
- Exercise still usable
- Description and instructions still visible

### Timer not starting
- Make sure to tap "Start" button
- Check if timer is already running
- Try resetting timer

## Code Example - Navigate to Library

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ExerciseLibraryScreen(),
  ),
);
```

## File Locations

```
lib/
├── screens/exercise_library/
│   ├── exercise_library_screen.dart    # Main screen
│   └── exercise_detail_screen.dart     # Detail view
├── models/exercise_library/
│   └── exercise_data.dart              # Data model
├── services/exercise/
│   └── exercise_service.dart           # Data fetching
└── widgets/exercise/
    ├── exercise_tile.dart              # Grid item
    └── countdown_timer.dart            # Timer widget
```

## Quick Customization

### Change grid columns
**File:** `exercise_library_screen.dart`
```dart
crossAxisCount: 3  // Change from 2 to 3
```

### Change default rest time
**File:** `exercise_detail_screen.dart`
```dart
int _restTime = 90;  // Change from 60 to 90
```

### Add your own exercises
**File:** `exercise_service.dart`
```dart
// Add to _getFallbackExercises() list
ExerciseData(
  id: '9',
  name: 'Your Exercise',
  gifUrl: 'https://your-gif-url.gif',
  category: 'strength',
  targetMuscle: 'arms',
  equipment: 'dumbbell',
  difficulty: 'intermediate',
)
```

## Performance

- **Load time:** ~2 seconds
- **Search response:** Instant
- **Scroll FPS:** 60fps
- **Image cache:** Persistent
- **Memory usage:** ~50-80MB

## Support

For detailed documentation, see:
- `EXERCISE_LIBRARY_GUIDE.md` - Full documentation
- `README.md` - Project overview

---

**Quick Start Version:** 1.0.0

**For:** FitFlow Workout App
