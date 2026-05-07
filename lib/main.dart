import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'services/database_service.dart';
import 'screens/auth/login_screen.dart';
import 'services/auth_service.dart';
import 'models/user_preferences.dart';
import 'models/workout_plan.dart';
import 'models/exercise.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';
import 'providers/workout_provider.dart';
import 'screens/onboarding/onboarding_flow.dart';
import 'screens/exercise_library/exercise_library_screen.dart';
import 'screens/calendar/calendar_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'widgets/workout/active_workout_card.dart';
import 'utils/navigation_utils.dart';
import 'utils/ui_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Provider.debugCheckInvalidValueType = null;

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  final dbService = DatabaseService();
  await dbService.isar;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider.value(value: _themeProvider),
      ],
      child: ListenableBuilder(
        listenable: _themeProvider,
        builder: (context, _) {
          return MaterialApp(
            title: 'FitFlow',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _themeProvider.themeMode,
            home: AppInitializer(themeProvider: _themeProvider),
          );
        },
      ),
    );
  }
}

class AppInitializer extends StatelessWidget {
  final ThemeProvider themeProvider;

  const AppInitializer({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }

        if (snapshot.data == null) {
          return const LoginScreen();
        }

        return _OnboardingGate(themeProvider: themeProvider);
      },
    );
  }
}

class _OnboardingGate extends StatefulWidget {
  final ThemeProvider themeProvider;

  const _OnboardingGate({required this.themeProvider});

  @override
  State<_OnboardingGate> createState() => _OnboardingGateState();
}

class _OnboardingGateState extends State<_OnboardingGate> {
  bool _isLoading = true;
  bool _hasCompletedOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await DatabaseService().getUserPreferences();
    if (mounted) {
      setState(() {
        _hasCompletedOnboarding = prefs != null;
        _isLoading = false;
      });
    }
  }

  void _completeOnboarding() => setState(() => _hasCompletedOnboarding = true);
  void _resetOnboarding() => setState(() => _hasCompletedOnboarding = false);

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    if (!_hasCompletedOnboarding) {
      return OnboardingFlow(onComplete: _completeOnboarding);
    }

    return HomeScreen(
      themeProvider: widget.themeProvider,
      onReset: _resetOnboarding,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final VoidCallback onReset;

  const HomeScreen({
    super.key,
    required this.themeProvider,
    required this.onReset,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();
  UserPreferences? _userPreferences;
  List<WorkoutPlan> _workoutPlans = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await _dbService.getUserPreferences();
    final plans = await _dbService.getAllWorkoutPlans();
    setState(() {
      _userPreferences = prefs;
      _workoutPlans = plans;
    });
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out?'),
        content: const Text('You will be signed out and taken back to the login screen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _dbService.deleteUserPreferences();
      await _dbService.deleteAllWorkoutPlans();
      await AuthService().signOut();
      // StreamBuilder in AppInitializer will automatically navigate to LoginScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitFlow'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Edit Profile',
            onPressed: () async {
              if (_userPreferences == null) return;
              final changed = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (_) => EditProfileScreen(
                    currentPreferences: _userPreferences!,
                    onReset: widget.onReset,
                  ),
                ),
              );
              if (changed == true) _loadData();
            },
          ),
          IconButton(
            icon: Icon(
              widget.themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.themeProvider.toggleTheme,
            tooltip: 'Toggle theme',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: _logout,
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.slideToPage(const ExerciseLibraryScreen()),
        icon: const Icon(Icons.search),
        label: const Text('Exercise Library'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ActiveWorkoutCard(),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () => context.slideToPage(const CalendarScreen()),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.secondary,
                                Theme.of(context).colorScheme.primary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.calendar_today, color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Workout Calendar',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('Track your progress & log workouts',
                                  style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () => context.slideToPage(const ExerciseLibraryScreen()),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.fitness_center, color: Colors.white, size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Exercise Library',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('Browse 100+ exercises with GIF demos',
                                  style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Text('User Preferences',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              if (_userPreferences != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Goal: ${_userPreferences!.goal?.name ?? "N/A"}'),
                        Text('Age: ${_userPreferences!.age ?? "N/A"}'),
                        Text(
                            'Weight: ${_userPreferences!.weight?.toStringAsFixed(1) ?? "N/A"} kg'),
                        Text(
                            'Height: ${_userPreferences!.height?.toStringAsFixed(1) ?? "N/A"} cm'),
                        Text(
                            'Fitness Level: ${_userPreferences!.fitnessLevel?.name ?? "N/A"}'),
                        if (_userPreferences!.bmi != null)
                          Text('BMI: ${_userPreferences!.bmi!.toStringAsFixed(1)}'),
                      ],
                    ),
                  ),
                )
              else
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No user preferences saved'),
                  ),
                ),
              const SizedBox(height: 24),
              Text('Workout Plans (${_workoutPlans.length})',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              _workoutPlans.isEmpty
                  ? const Card(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: Text('No workout plans saved')),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _workoutPlans.length,
                      itemBuilder: (context, index) {
                        final plan = _workoutPlans[index];
                        return Card(
                          child: ExpansionTile(
                            title: Text(plan.name ?? 'Unnamed Plan'),
                            subtitle: Text(plan.description ?? 'No description'),
                            children: [
                              if (plan.exercises != null && plan.exercises!.isNotEmpty)
                                ...plan.exercises!.map((exercise) => ListTile(
                                      dense: true,
                                      title: Text(exercise.title ?? 'Unnamed Exercise'),
                                      subtitle: Text(
                                          '${exercise.sets} sets × ${exercise.duration}s'),
                                    ))
                              else
                                const ListTile(title: Text('No exercises')),
                            ],
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
