import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/user_preferences.dart';
import '../../services/database_service.dart';
import '../../services/user_service.dart';
import '../../services/workout/workout_generator.dart';
import 'welcome_screen.dart';
import 'goal_selection_screen.dart';
import 'body_metrics_screen.dart';
import 'fitness_level_screen.dart';
import 'permissions_screen.dart';

class OnboardingFlow extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingFlow({
    super.key,
    required this.onComplete,
  });

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  final DatabaseService _dbService = DatabaseService();

  int _currentPage = 0;
  FitnessGoal? _selectedGoal;
  int _age = 25;
  double _weight = 70.0;
  double _height = 170.0;
  FitnessLevel? _selectedLevel;

  bool get _canContinue {
    switch (_currentPage) {
      case 0:
        return true;
      case 1:
        return _selectedGoal != null;
      case 2:
        return true;
      case 3:
        return _selectedLevel != null;
      case 4:
        return true;
      default:
        return false;
    }
  }

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    if (_selectedGoal == null || _selectedLevel == null) return;

    final preferences = UserPreferences(
      goal: _selectedGoal,
      age: _age,
      weight: _weight,
      height: _height,
      fitnessLevel: _selectedLevel,
    );

    await _dbService.createOrUpdateUserPreferences(preferences);
    await UserService().saveProfile(preferences);

    // Generate 7-day workout plan
    final workoutPlans = WorkoutGenerator.generate7DayPlan(preferences);

    // Save all plans to database
    await _dbService.saveWorkoutPlans(workoutPlans);

    widget.onComplete();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              WelcomeScreen(
                onGetStarted: _nextPage,
              ),
              GoalSelectionScreen(
                selectedGoal: _selectedGoal,
                onGoalSelected: (goal) {
                  setState(() {
                    _selectedGoal = goal;
                  });
                },
              ),
              BodyMetricsScreen(
                initialAge: _age,
                initialWeight: _weight,
                initialHeight: _height,
                onMetricsUpdated: (age, weight, height) {
                  _age = age;
                  _weight = weight;
                  _height = height;
                },
              ),
              FitnessLevelScreen(
                selectedLevel: _selectedLevel,
                onLevelSelected: (level) {
                  setState(() {
                    _selectedLevel = level;
                  });
                },
              ),
              PermissionsScreen(
                onComplete: _completeOnboarding,
              ),
            ],
          ),
          if (_currentPage > 0)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back_ios_new),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.8),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    if (_currentPage < 4)
                      AnimatedSmoothIndicator(
                        activeIndex: _currentPage - 1,
                        count: 4,
                        effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          dotColor: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.2),
                        ),
                      ),
                    if (_currentPage < 4 && _currentPage > 0)
                      IconButton(
                        onPressed: _canContinue ? _nextPage : null,
                        icon: const Icon(Icons.arrow_forward_ios),
                        style: IconButton.styleFrom(
                          backgroundColor: _canContinue
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.1),
                          foregroundColor:
                              _canContinue ? Colors.white : Colors.grey,
                          padding: const EdgeInsets.all(12),
                        ),
                      )
                    else
                      const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
