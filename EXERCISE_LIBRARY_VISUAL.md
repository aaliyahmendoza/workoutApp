# Exercise Library - Visual Flow

## Navigation Flow

```
Home Screen
    │
    ├─► [Tap Exercise Library Card]
    │       │
    │       ↓
    └─► Exercise Library Screen
            │
            ├─► [Search Icon] → Search Mode
            │   │
            │   ├─► Type Query → Filter Results
            │   └─► [X] Clear → Reset Search
            │
            ├─► [Category Chip] → Filter by Category
            │   │
            │   └─► [All] → Reset Filter
            │
            └─► [Tap Exercise Tile]
                    │
                    ↓
                Exercise Detail Screen
                    │
                    ├─► [Start Rest Timer] → Show Timer
                    │   │
                    │   ├─► [Start/Pause] → Control Timer
                    │   ├─► [Reset] → Reset Timer
                    │   └─► [Hide Timer] → Hide Timer
                    │
                    ├─► [Settings ⚙️] → Settings Sheet
                    │   │
                    │   ├─► Adjust Slider → Change Rest Time
                    │   ├─► [Tap Preset] → Quick Set
                    │   └─► [Save] → Apply & Close
                    │
                    └─► [Back] → Return to Library
```

## Screen Breakdown

### 1. Exercise Library Screen

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ ╔═══════════════════════════════════════╗ ┃
┃ ║   [Gradient Background Header]        ║ ┃
┃ ║   ← Back              🔍 Search       ║ ┃
┃ ║                                       ║ ┃
┃ ║   Exercise Library                    ║ ┃
┃ ║   100 exercises available             ║ ┃
┃ ╚═══════════════════════════════════════╝ ┃
┃                                           ┃
┃ [Search Bar - Expandable]                 ┃
┃ ┌─────────────────────────────────────┐   ┃
┃ │ 🔍 Search exercises...          ✕   │   ┃
┃ └─────────────────────────────────────┘   ┃
┃                                           ┃
┃ Category Filters (Horizontal Scroll)      ┃
┃ ┌────┬────────┬────────┬──────┬────────┐  ┃
┃ │All │Strength│ Cardio │ Core │  ...   │  ┃
┃ └────┴────────┴────────┴──────┴────────┘  ┃
┃                                           ┃
┃ Exercise Grid (2 Columns)                 ┃
┃ ┌──────────────┬──────────────┐           ┃
┃ │ ┌──────────┐ │ ┌──────────┐ │           ┃
┃ │ │  [GIF]   │ │ │  [GIF]   │ │           ┃
┃ │ │          │ │ │          │ │           ┃
┃ │ │ BEGINNER │ │ │INTERMED. │ │           ┃
┃ │ └──────────┘ │ └──────────┘ │           ┃
┃ │ Push-ups     │ Squats       │           ┃
┃ │ 💪 chest     │ 🦵 legs      │           ┃
┃ │ bodyweight   │ bodyweight   │           ┃
┃ └──────────────┴──────────────┘           ┃
┃ ┌──────────────┬──────────────┐           ┃
┃ │ ┌──────────┐ │ ┌──────────┐ │           ┃
┃ │ │  [GIF]   │ │ │  [GIF]   │ │           ┃
┃ │ │          │ │ │          │ │           ┃
┃ │ │ BEGINNER │ │ │INTERMED. │ │           ┃
┃ │ └──────────┘ │ └──────────┘ │           ┃
┃ │ Plank        │ Burpees      │           ┃
┃ │ 🧘 core      │ 🏃 full body │           ┃
┃ │ bodyweight   │ bodyweight   │           ┃
┃ └──────────────┴──────────────┘           ┃
┃       (Scroll for more...)                ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### 2. Exercise Detail Screen

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ ╔═══════════════════════════════════════╗ ┃
┃ ║                                       ║ ┃
┃ ║                                       ║ ┃
┃ ║          [Full Screen GIF]            ║ ┃
┃ ║         Exercise Animation            ║ ┃
┃ ║                                       ║ ┃
┃ ║  ← Back                     ♡         ║ ┃
┃ ╚═══════════════════════════════════════╝ ┃
┃                                           ┃
┃ ┌─────────────────────────────────────┐   ┃
┃ │ [BEGINNER]                          │   ┃
┃ │                                     │   ┃
┃ │ Push-ups                            │   ┃
┃ └─────────────────────────────────────┘   ┃
┃                                           ┃
┃ Info Cards                                ┃
┃ ┌───────┬───────────┬──────────────┐      ┃
┃ │Category│  Target   │   Equipment  │      ┃
┃ │   🏋️   │     💪    │      🎯      │      ┃
┃ │Strength│   Chest   │  Bodyweight  │      ┃
┃ └───────┴───────────┴──────────────┘      ┃
┃                                           ┃
┃ ┌─────────────────────────────────────┐   ┃
┃ │ Description                         │   ┃
┃ │                                     │   ┃
┃ │ A classic upper body exercise       │   ┃
┃ │ targeting chest, shoulders, and     │   ┃
┃ │ triceps.                            │   ┃
┃ └─────────────────────────────────────┘   ┃
┃                                           ┃
┃ Instructions                              ┃
┃ ┌─────────────────────────────────────┐   ┃
┃ │ ① Start in a plank position with    │   ┃
┃ │   hands shoulder-width apart        │   ┃
┃ │                                     │   ┃
┃ │ ② Lower your body until your chest  │   ┃
┃ │   nearly touches the floor          │   ┃
┃ │                                     │   ┃
┃ │ ③ Push back up to starting position │   ┃
┃ │                                     │   ┃
┃ │ ④ Keep your core engaged throughout │   ┃
┃ └─────────────────────────────────────┘   ┃
┃                                           ┃
┃ ┌──────────────────────────┬────────┐     ┃
┃ │ [▶] Start Rest Timer     │ [⚙️]   │     ┃
┃ └──────────────────────────┴────────┘     ┃
┃                                           ┃
┃ ╔═══════════════════════════════════════╗ ┃
┃ ║          Rest Timer                   ║ ┃
┃ ║  ┌────────────────────────────────┐   ║ ┃
┃ ║  │       ◯ ──────────60%          │   ║ ┃
┃ ║  │                                │   ║ ┃
┃ ║  │         01:00                  │   ║ ┃
┃ ║  │       Keep resting             │   ║ ┃
┃ ║  │                                │   ║ ┃
┃ ║  │  [↻ Reset]    [▶ Start]       │   ║ ┃
┃ ║  └────────────────────────────────┘   ║ ┃
┃ ╚═══════════════════════════════════════╝ ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### 3. Settings Bottom Sheet

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                           ┃
┃   (Dimmed Background - Detail Screen)     ┃
┃                                           ┃
┃  ╔════════════════════════════════════╗   ┃
┃  ║  ─────                             ║   ┃
┃  ║                                    ║   ┃
┃  ║  Rest Time Settings          ✕    ║   ┃
┃  ║  ─────────────────────────────────  ║   ┃
┃  ║                                    ║   ┃
┃  ║  Rest Duration            60s      ║   ┃
┃  ║                                    ║   ┃
┃  ║  ────●─────────────────────────    ║   ┃
┃  ║  15s                          5m   ║   ┃
┃  ║                                    ║   ┃
┃  ║  Quick Presets:                    ║   ┃
┃  ║  ┌────┬────┬────┬────┐            ║   ┃
┃  ║  │30s │60s │90s │120s│            ║   ┃
┃  ║  └────┴────┴────┴────┘            ║   ┃
┃  ║                                    ║   ┃
┃  ║  ┌──────────────────────────────┐ ║   ┃
┃  ║  │     Save Settings            │ ║   ┃
┃  ║  └──────────────────────────────┘ ║   ┃
┃  ║                                    ║   ┃
┃  ╚════════════════════════════════════╝   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

## Component Hierarchy

```
ExerciseLibraryScreen
├── CustomScrollView
│   ├── SliverAppBar (Gradient Header)
│   │   ├── Back Button
│   │   ├── Search Toggle
│   │   └── Title + Subtitle
│   │
│   ├── PreferredSize (Search Bar)
│   │   └── TextField / Placeholder
│   │
│   ├── SliverToBoxAdapter (Category Chips)
│   │   └── ListView.builder (Horizontal)
│   │       └── FilterChip (per category)
│   │
│   └── SliverGrid (Exercise Grid)
│       └── ExerciseTile (per exercise)
│           ├── CachedNetworkImage (GIF)
│           ├── Difficulty Badge
│           ├── Exercise Name
│           ├── Target Muscle
│           └── Equipment Badge
│
└── Navigation → ExerciseDetailScreen
```

```
ExerciseDetailScreen
├── CustomScrollView
│   ├── SliverAppBar (Full GIF)
│   │   ├── Hero Animation
│   │   ├── Back Button
│   │   └── Favorite Button
│   │
│   └── SliverToBoxAdapter
│       ├── Header (Difficulty + Name)
│       ├── Info Cards Row
│       │   ├── Category Card
│       │   ├── Target Card
│       │   └── Equipment Card
│       ├── Description Section
│       ├── Instructions List
│       ├── Action Buttons
│       │   ├── Timer Toggle Button
│       │   └── Settings Button
│       └── CountdownTimer (Conditional)
│           ├── Circular Progress
│           ├── Time Display
│           ├── Status Text
│           └── Control Buttons
│
└── showModalBottomSheet (Settings)
    ├── Handle Bar
    ├── Title + Close
    ├── Rest Duration Display
    ├── Slider (15-300s)
    ├── Preset Buttons
    └── Save Button
```

## Animation Flow

### Library Screen Entrance
```
1. App Bar slides down (200ms)
2. Search bar fades in (300ms)
3. Category chips slide in (400ms)
4. Grid items stagger (50ms each)
```

### Exercise Tile → Detail
```
1. Hero animation (300ms)
   - GIF scales & moves
2. Content fades in (200ms)
   - Info cards
   - Description
   - Instructions
3. Buttons slide up (100ms)
```

### Timer Appearance
```
1. Timer container expands (300ms)
2. Content fades in (200ms)
3. Circular progress draws (400ms)
```

### Settings Sheet
```
1. Sheet slides up (300ms)
2. Content fades in (200ms)
3. Slider thumb pulses on change
```

## State Flow

```
Initial State
    │
    ├─► Load Exercises (async)
    │   ├─► Success → Display Grid
    │   └─► Error → Show Fallback Data
    │
    ├─► User Types Search
    │   └─► Filter Results (sync)
    │
    ├─► User Selects Category
    │   └─► Filter Results (sync)
    │
    └─► User Taps Tile
        └─► Navigate to Detail
            │
            ├─► Toggle Timer
            │   ├─► Show Timer
            │   └─► Hide Timer
            │
            ├─► Start Timer
            │   └─► Countdown (1s intervals)
            │       └─► On Complete → Callback
            │
            └─► Open Settings
                └─► Adjust Rest Time
                    └─► Save → Update Timer
```

## Color Scheme

### Difficulty Colors
```
┌──────────────┬──────────┬──────────┐
│  Beginner    │   Int.   │ Advanced │
├──────────────┼──────────┼──────────┤
│ #4CAF50  ███ │ #FF9800  │ #FF6584  │
│  Green       │  Orange  │   Pink   │
└──────────────┴──────────┴──────────┘
```

### Info Card Colors
```
┌────────────┬─────────┬───────────┐
│  Category  │ Target  │ Equipment │
├────────────┼─────────┼───────────┤
│ #6C63FF ██ │ #FF6584 │ #4CAF50   │
│  Purple    │  Pink   │   Green   │
└────────────┴─────────┴───────────┘
```

### Timer States
```
Normal:   Primary Color (#6C63FF)
Warning:  Red (#FF6584) - Last 10s
Paused:   Gray (opacity 0.6)
Complete: Success Green (#4CAF50)
```

## Responsive Layout

### Mobile (< 600px width)
```
Grid: 2 columns
Search: Full width
Categories: Horizontal scroll
Tile height: Dynamic (0.75 aspect)
```

### Tablet (600-900px width)
```
Grid: 3 columns
Search: Centered (80% width)
Categories: Wrap to multiple rows
Tile height: Fixed (200px)
```

### Desktop (> 900px width)
```
Grid: 4 columns
Search: Centered (60% width)
Categories: All visible
Tile height: Fixed (220px)
Hover effects: Enabled
```

## Data Flow

```
GitHub JSON API
      ↓
ExerciseService.fetchExercises()
      ↓
Parse JSON → ExerciseData objects
      ↓
Store in _allExercises list
      ↓
Apply Filters
  ├─► Search Query
  └─► Category Filter
      ↓
Update _filteredExercises
      ↓
Rebuild Grid
      ↓
CachedNetworkImage loads GIFs
      ↓
Cache for future use
```

## Touch Targets

All interactive elements meet 48x48dp minimum:
- ✅ Exercise tiles: 48x48+ (full card)
- ✅ Category chips: 48x48
- ✅ Search button: 48x48
- ✅ Back button: 48x48
- ✅ Timer buttons: 56x48
- ✅ Settings button: 56x56

## Performance Optimization

```
Initial Load
├─► Fetch 100 exercises (2s)
├─► Cache management setup
└─► Render visible grid items only

Scroll
├─► Lazy load off-screen items
├─► Maintain smooth 60fps
└─► Recycle tile widgets

GIF Loading
├─► Show placeholder immediately
├─► Load from cache if available
├─► Download if needed
└─► Cache for next view

Search/Filter
├─► Debounce text input (300ms)
├─► Filter in isolate if >1000 items
└─► Animate result changes
```

---

**Visual Flow Complete** 🎨

This document provides a complete visual representation of the Exercise Library feature, including all screens, components, animations, and interactions.
