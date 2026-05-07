# Onboarding Flow Guide

## Overview

The app features a sophisticated 5-screen onboarding flow with smooth animations, custom theme support, and interactive elements.

## Onboarding Screens

### 1. Welcome Screen
**File:** `lib/screens/onboarding/welcome_screen.dart`

**Features:**
- Animated gradient background with floating orbs
- Fade-in and scale animations for logo and text
- Slide-up animation for the CTA button
- "Get Started" button to begin onboarding

**Customization:**
- Change app name in the title text
- Modify gradient colors in `AnimatedBackground`
- Adjust animation timing in `initState()`

### 2. Goal Selection Screen
**File:** `lib/screens/onboarding/goal_selection_screen.dart`

**Features:**
- 5 fitness goal options with custom icons and gradients
- Card-style selectors with press animations
- Selected state with gradient background and shadow
- Staggered fade-in animations

**Available Goals:**
- Lose Weight (Red gradient)
- Build Muscle (Purple gradient)
- Maintain Fitness (Green gradient)
- Increase Endurance (Orange gradient)
- General Fitness (Cyan gradient)

**Customization:**
```dart
GoalOption(
  goal: FitnessGoal.yourGoal,
  title: 'Your Title',
  description: 'Your description',
  icon: Icons.your_icon,
  gradient: [Color(0xFFHEX1), Color(0xFFHEX2)],
)
```

### 3. Body Metrics Screen
**File:** `lib/screens/onboarding/body_metrics_screen.dart`

**Features:**
- Interactive sliders for Age, Weight, and Height
- Real-time BMI calculation and display
- BMI category indicator (Underweight, Normal, Overweight, Obese)
- Gradient icon containers
- Smooth value updates

**Ranges:**
- Age: 15-80 years
- Weight: 40-150 kg
- Height: 140-220 cm

**Customization:**
- Modify ranges in slider `min` and `max` properties
- Change gradient colors per metric
- Adjust BMI calculation in `_bmi` getter

### 4. Fitness Level Screen
**File:** `lib/screens/onboarding/fitness_level_screen.dart`

**Features:**
- 3 experience levels (Beginner, Intermediate, Advanced)
- Large, detailed cards with descriptions
- Experience timeline indicators
- Gradient backgrounds for selected state
- Staggered animations

**Customization:**
```dart
LevelOption(
  level: FitnessLevel.yourLevel,
  title: 'Title',
  description: 'Description',
  details: 'Experience range',
  icon: Icons.your_icon,
  gradient: [Color(0xFFHEX1), Color(0xFFHEX2)],
)
```

### 5. Permissions Screen
**File:** `lib/screens/onboarding/permissions_screen.dart`

**Features:**
- Notifications permission request
- Health data access (Apple Health/Google Fit)
- Optional permission indicators
- Grant status indicators
- Info banner about changing permissions later

**Permissions:**
- **Notifications**: For workout reminders
- **Health Data**: For fitness tracking (optional)

## Theme System

### App Theme
**File:** `lib/theme/app_theme.dart`

**Features:**
- Complete light and dark theme definitions
- Custom color scheme with primary and accent colors
- Material 3 design system
- Consistent styling for buttons, cards, inputs, and sliders

**Colors:**
- Primary: `#6C63FF` (Purple)
- Accent: `#FF6584` (Pink)
- Success: `#4CAF50` (Green)

**Customization:**
```dart
static const primaryColor = Color(0xFFYOURCOLOR);
static const accentColor = Color(0xFFYOURCOLOR);
```

### Theme Provider
**File:** `lib/theme/theme_provider.dart`

**Features:**
- Theme mode management (light/dark/system)
- Toggle between light and dark mode
- ListenableBuilder integration for reactive updates

**Usage:**
```dart
// Toggle theme
themeProvider.toggleTheme();

// Set specific theme
themeProvider.setThemeMode(ThemeMode.dark);

// Check if dark mode
bool isDark = themeProvider.isDarkMode;
```

## Onboarding Flow Controller

**File:** `lib/screens/onboarding/onboarding_flow.dart`

**Features:**
- PageView-based navigation
- Progress indicator (smooth_page_indicator)
- Back/forward navigation buttons
- Validation before proceeding
- Saves data to Isar database on completion

**Flow Logic:**
1. Welcome screen (no validation needed)
2. Goal selection (requires goal selection)
3. Body metrics (no validation, auto-updates)
4. Fitness level (requires level selection)
5. Permissions (optional, completes onboarding)

## Integration with Main App

**File:** `lib/main.dart`

The app checks for existing user preferences on startup:
- If preferences exist → Show HomeScreen
- If no preferences → Show OnboardingFlow

```dart
Future<void> _checkOnboardingStatus() async {
  final dbService = DatabaseService();
  final prefs = await dbService.getUserPreferences();
  
  setState(() {
    _hasCompletedOnboarding = prefs != null;
    _isLoading = false;
  });
}
```

## Animations

### Welcome Screen
- **Fade + Scale**: Logo and title (0-600ms)
- **Slide up**: Button (300-1500ms)
- **Continuous rotation**: Background orbs (20s loop)

### Goal/Level Selection
- **Staggered fade-in**: Cards appear sequentially (400ms + 100ms per index)
- **Scale on press**: Cards shrink to 98% on tap
- **Shadow animation**: Selected cards get elevated shadow

### Body Metrics
- **Fade-in**: Entire screen (800ms)
- **Real-time updates**: Values update on slider change

### Permissions
- **Fade-in**: Screen content (800ms)
- **Button state**: Animates between enabled/disabled states

## Customization Guide

### Change Color Scheme

1. Update `lib/theme/app_theme.dart`:
```dart
static const primaryColor = Color(0xFFYOURCOLOR);
static const accentColor = Color(0xFFYOURCOLOR);
```

2. Update gradients in selection screens:
```dart
gradient: [Color(0xFFNEW1), Color(0xFFNEW2)]
```

### Add New Goal/Level Options

1. Add enum value to `lib/models/user_preferences.dart`:
```dart
enum FitnessGoal {
  // existing goals...
  yourNewGoal,
}
```

2. Add option to screen list:
```dart
GoalOption(
  goal: FitnessGoal.yourNewGoal,
  title: 'Your Goal',
  description: 'Description',
  icon: Icons.your_icon,
  gradient: [Color(0xFF...), Color(0xFF...)],
)
```

### Modify Animation Timing

Adjust in screen's `initState()`:
```dart
_controller = AnimationController(
  duration: const Duration(milliseconds: YOUR_DURATION),
  vsync: this,
);
```

### Change Welcome Screen

Replace animated background or add video:
```dart
// For video background (requires video_player setup):
VideoPlayer(_controller)
```

## Required Permissions

### Android
**File:** `android/app/src/main/AndroidManifest.xml`

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION"/>
<uses-permission android:name="android.permission.HEALTH_CONNECT"/>
```

### iOS
**File:** `ios/Runner/Info.plist`

```xml
<key>NSHealthShareUsageDescription</key>
<string>We need access to your health data to track your fitness progress</string>
<key>NSHealthUpdateUsageDescription</key>
<string>We need to update your health data with workout information</string>
```

## Testing

### Reset Onboarding
To test the flow again:
```dart
await DatabaseService().deleteUserPreferences();
// Restart app
```

### Skip Onboarding (Development)
In `main.dart`:
```dart
setState(() {
  _hasCompletedOnboarding = true; // Force skip
  _isLoading = false;
});
```

## Tips

1. **Smooth Animations**: Keep animation durations under 800ms for snappy feel
2. **Dark Mode**: Test both themes to ensure proper contrast
3. **Accessibility**: Use semantic labels for screen readers
4. **Performance**: Avoid heavy computations in build methods
5. **UX**: Validate inputs but don't block user progress unnecessarily

## Future Enhancements

- [ ] Add video background support with actual video file
- [ ] Implement skip button for returning users
- [ ] Add tutorial tooltips
- [ ] Include app walkthrough after onboarding
- [ ] Social sign-in options on welcome screen
- [ ] Animated success screen after completion
