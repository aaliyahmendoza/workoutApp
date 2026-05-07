# FitFlow Onboarding - Visual Flow

## Screen Flow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         APP LAUNCH                               │
│                            ↓                                     │
│                   Check User Preferences                         │
│                            ↓                                     │
│              ┌─────────────┴─────────────┐                      │
│              ↓                           ↓                       │
│      Preferences Exist           No Preferences                  │
│              ↓                           ↓                       │
│        HOME SCREEN              ONBOARDING FLOW                  │
└─────────────────────────────────────────────────────────────────┘
```

## Onboarding Flow (5 Screens)

```
┌──────────────────────────────────────────────────────────────────┐
│ SCREEN 1: WELCOME                                                │
│ ┌────────────────────────────────────────────────────────────┐  │
│ │                                                            │  │
│ │              ┌───────────────┐                            │  │
│ │              │  🏋️  LOGO     │  (Animated gradient)       │  │
│ │              └───────────────┘                            │  │
│ │                                                            │  │
│ │            Welcome to FitFlow                              │  │
│ │     Your personal fitness journey                          │  │
│ │            starts here                                     │  │
│ │                                                            │  │
│ │                                                            │  │
│ │         ┌───────────────────────┐                          │  │
│ │         │   Get Started  →     │                          │  │
│ │         └───────────────────────┘                          │  │
│ │                                                            │  │
│ │      Transform your body, elevate your mind               │  │
│ └────────────────────────────────────────────────────────────┘  │
│                           ↓ (Tap button)                         │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ SCREEN 2: GOAL SELECTION                                         │
│ ┌────────────────────────────────────────────────────────────┐  │
│ │  ← Back          What's your goal?          ●○○○          │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │ 📉 Lose Weight                              ✓     │   │  │
│ │  │    Burn calories and shed pounds                  │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │ 🏋️ Build Muscle                             ○     │   │  │
│ │  │    Gain strength and muscle mass                  │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │ ❤️ Maintain Fitness                         ○     │   │  │
│ │  │    Stay healthy and active                        │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  [More options...]                                         │  │
│ └────────────────────────────────────────────────────────────┘  │
│                           ↓ (Select goal → Next)                │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ SCREEN 3: BODY METRICS                                           │
│ ┌────────────────────────────────────────────────────────────┐  │
│ │  ← Back          Body Metrics               ○●○○           │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  🎂 Age                            25 years        │   │  │
│ │  │  ─────●──────────────────────────────────         │   │  │
│ │  │  15                                           80    │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  ⚖️ Weight                          70.0 kg        │   │  │
│ │  │  ──────────●──────────────────────────────         │   │  │
│ │  │  40 kg                                     150 kg   │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  📏 Height                         170 cm          │   │  │
│ │  │  ─────────●───────────────────────────────         │   │  │
│ │  │  140 cm                                    220 cm   │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │         📊 Your BMI: 24.2                          │   │  │
│ │  │              Normal                                 │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ └────────────────────────────────────────────────────────────┘  │
│                           ↓ (Adjust → Next)                     │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ SCREEN 4: FITNESS LEVEL                                          │
│ ┌────────────────────────────────────────────────────────────┐  │
│ │  ← Back        Fitness Level                ○○●○           │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  🚶 Beginner                              ○        │   │  │
│ │  │     0-6 months of experience                       │   │  │
│ │  │     New to fitness or returning after a break      │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  🏃 Intermediate                          ✓        │   │  │
│ │  │     6-24 months of experience                      │   │  │
│ │  │     Regular workout routine established            │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  🏆 Advanced                              ○        │   │  │
│ │  │     2+ years of experience                         │   │  │
│ │  │     Experienced athlete with strong foundation     │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ └────────────────────────────────────────────────────────────┘  │
│                           ↓ (Select level → Next)               │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ SCREEN 5: PERMISSIONS                                            │
│ ┌────────────────────────────────────────────────────────────┐  │
│ │  ← Back          Permissions                ○○○●           │  │
│ │                                                            │  │
│ │  Enable features for the best experience                  │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  🔔 Notifications                                  │   │  │
│ │  │     Get reminders for workouts and tips            │   │  │
│ │  │                                                     │   │  │
│ │  │     ┌─────────────────────────────────┐            │   │  │
│ │  │     │  🔓 Grant Permission            │            │   │  │
│ │  │     └─────────────────────────────────┘            │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ┌────────────────────────────────────────────────────┐   │  │
│ │  │  ❤️ Health Data               [Optional]          │   │  │
│ │  │     Sync with Apple Health or Google Fit           │   │  │
│ │  │                                                     │   │  │
│ │  │     ┌─────────────────────────────────┐            │   │  │
│ │  │     │  ✓ Granted                      │            │   │  │
│ │  │     └─────────────────────────────────┘            │   │  │
│ │  └────────────────────────────────────────────────────┘   │  │
│ │                                                            │  │
│ │  ℹ️ You can change these permissions anytime in Settings │  │
│ │                                                            │  │
│ │         ┌───────────────────────┐                          │  │
│ │         │      Continue  →     │                          │  │
│ │         └───────────────────────┘                          │  │
│ └────────────────────────────────────────────────────────────┘  │
│                    ↓ (Save to database → Complete)              │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                      HOME SCREEN                                 │
│  (User preferences loaded, ready to create workout plans)        │
└──────────────────────────────────────────────────────────────────┘
```

## UI Components Legend

```
┌───────────┐
│  Button   │  Primary action button (gradient background)
└───────────┘

┌───────────────────────────────────┐
│  ●  Card Item              ✓     │  Selectable card (selected = gradient)
│      Description text              │
└───────────────────────────────────┘

─────●─────────────  Slider (interactive)

●○○○  Progress indicator (current = filled)

←  Back button

→  Forward/Next indicator

🔔 💪 ❤️ 📊  Icons (Material Icons)
```

## Animation Flow

```
Welcome Screen:
├─ Logo: Fade + Scale (0-600ms)
├─ Text: Fade (0-600ms)
└─ Button: Slide up (300-1500ms)

Selection Screens:
├─ Title: Fade (0-400ms)
├─ Cards: Staggered fade + slide (0-100ms delay each)
└─ Press: Scale to 0.98 (200ms)

Body Metrics:
├─ Content: Fade (0-800ms)
├─ Slider: Real-time value update
└─ BMI: Calculate on change

Permissions:
├─ Content: Fade (0-800ms)
└─ Button states: Color transition (200ms)
```

## Color Scheme

```
Primary:   #6C63FF  ███  (Purple)
Accent:    #FF6584  ███  (Pink)
Success:   #4CAF50  ███  (Green)
Warning:   #FF9800  ███  (Orange)
Info:      #00BCD4  ███  (Cyan)

Light Mode Background:  #F8F9FA  ███
Dark Mode Background:   #0A0A0A  ███

Card Light:  #FFFFFF  ███
Card Dark:   #1A1A1A  ███
```

## Theme Toggle

```
┌─────────────────────────────────┐
│  FitFlow          🌙 / ☀️      │  ← App bar with theme toggle
├─────────────────────────────────┤
│                                 │
│  [Content adapts to theme]      │
│                                 │
└─────────────────────────────────┘

Light Mode:
- White/light gray backgrounds
- Dark text
- Soft shadows
- Sun icon

Dark Mode:
- Black/dark gray backgrounds
- Light text
- Subtle borders
- Moon icon
```

## Navigation Pattern

```
Screen 1 (Welcome):
- No back button
- "Get Started" button only

Screens 2-4 (Selections):
- Back button (top left)
- Progress dots (top center)
- Next button (top right, enabled when valid selection)

Screen 5 (Permissions):
- Back button (top left)
- No progress dots
- "Continue" button (bottom, always enabled)
```

## Data Collection Summary

```
┌────────────────────────────────────────────┐
│  Data Collected During Onboarding:        │
├────────────────────────────────────────────┤
│  ✓ Fitness Goal (enum)                    │
│  ✓ Age (15-80)                            │
│  ✓ Weight (40-150 kg)                     │
│  ✓ Height (140-220 cm)                    │
│  ✓ Fitness Level (enum)                   │
│  ○ Notification Permission (optional)     │
│  ○ Health Data Permission (optional)      │
├────────────────────────────────────────────┤
│  Calculated:                              │
│  ✓ BMI (auto-calculated)                  │
│  ✓ Created At timestamp                   │
│  ✓ Updated At timestamp                   │
└────────────────────────────────────────────┘
```

## File Reference

```
lib/screens/onboarding/
├── onboarding_flow.dart       ← Main controller
├── welcome_screen.dart         ← Screen 1
├── goal_selection_screen.dart  ← Screen 2
├── body_metrics_screen.dart    ← Screen 3
├── fitness_level_screen.dart   ← Screen 4
└── permissions_screen.dart     ← Screen 5

lib/theme/
├── app_theme.dart             ← Theme definitions
└── theme_provider.dart        ← Theme state

lib/models/
└── user_preferences.dart      ← Data model (enums + class)

lib/services/
└── database_service.dart      ← Isar database CRUD
```

## Quick Commands

```bash
# Run the app
flutter run

# Reset onboarding (clear data via UI button)
# Or programmatically:
await DatabaseService().deleteUserPreferences();

# Build for production
flutter build apk          # Android
flutter build ios          # iOS
flutter build windows      # Windows
```

---

**Visual Flow Complete** ✨

This document provides a visual representation of the entire onboarding experience. For implementation details, see `ONBOARDING_GUIDE.md` and `ONBOARDING_COMPLETE.md`.
