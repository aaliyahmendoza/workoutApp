import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const PermissionsScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen>
    with TickerProviderStateMixin {
  bool _notificationsGranted = false;
  bool _healthGranted = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _checkPermissions();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    final notificationStatus = await Permission.notification.status;
    setState(() {
      _notificationsGranted = notificationStatus.isGranted;
    });
  }

  Future<void> _requestNotifications() async {
    final status = await Permission.notification.request();
    setState(() {
      _notificationsGranted = status.isGranted;
    });
  }

  Future<void> _requestHealthData() async {
    setState(() {
      _healthGranted = true;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Health data access simulated'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Permissions',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Enable features for the best experience',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _buildPermissionCard(
                    title: 'Notifications',
                    description:
                        'Get reminders for workouts and motivational tips',
                    icon: Icons.notifications_active,
                    gradient: const [Color(0xFF6C63FF), Color(0xFF8E86FF)],
                    isGranted: _notificationsGranted,
                    onRequest: _requestNotifications,
                  ),
                  const SizedBox(height: 16),
                  _buildPermissionCard(
                    title: 'Health Data',
                    description:
                        'Sync with Apple Health or Google Fit for better tracking',
                    icon: Icons.favorite,
                    gradient: const [Color(0xFFFF6584), Color(0xFFFF8A9B)],
                    isGranted: _healthGranted,
                    onRequest: _requestHealthData,
                    isOptional: true,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You can change these permissions anytime in Settings',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: widget.onComplete,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionCard({
    required String title,
    required String description,
    required IconData icon,
    required List<Color> gradient,
    required bool isGranted,
    required VoidCallback onRequest,
    bool isOptional = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isGranted
              ? gradient.first.withOpacity(0.5)
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        if (isOptional) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Optional',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isGranted ? null : onRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: isGranted
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : gradient.first,
                foregroundColor: isGranted
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                disabledBackgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.2),
                disabledForegroundColor:
                    Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isGranted ? Icons.check_circle : Icons.lock_open,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isGranted ? 'Granted' : 'Grant Permission',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
