import 'package:flutter/material.dart';
import '../../models/user_preferences.dart';
import '../../utils/unit_converter.dart';

class BodyMetricsScreen extends StatefulWidget {
  final int? initialAge;
  final double? initialWeight;
  final double? initialHeight;
  final Function(int age, double weight, double height) onMetricsUpdated;

  const BodyMetricsScreen({
    super.key,
    this.initialAge,
    this.initialWeight,
    this.initialHeight,
    required this.onMetricsUpdated,
  });

  @override
  State<BodyMetricsScreen> createState() => _BodyMetricsScreenState();
}

class _BodyMetricsScreenState extends State<BodyMetricsScreen> {
  late int _age;
  late double _weight; // stored in kg
  late double _height; // stored in cm
  WeightUnit _weightUnit = WeightUnit.kg;
  HeightUnit _heightUnit = HeightUnit.cm;

  @override
  void initState() {
    super.initState();
    _age = widget.initialAge ?? 25;
    _weight = widget.initialWeight ?? 70.0;
    _height = widget.initialHeight ?? 170.0;
  }

  void _updateMetrics() {
    // Debounce updates to reduce system load
    Future.microtask(() {
      widget.onMetricsUpdated(_age, _weight, _height);
    });
  }

  double? get _bmi {
    if (_weight <= 0 || _height <= 0) return null;
    return _weight / ((_height / 100) * (_height / 100));
  }

  String get _bmiCategory {
    final bmi = _bmi;
    if (bmi == null) return '';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Body Metrics',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Help us personalize your workout plan',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _buildMetricCard(
                    title: 'Age',
                    value: _age.toString(),
                    unit: 'years',
                    icon: Icons.cake,
                    gradient: const [Color(0xFF6C63FF), Color(0xFF8E86FF)],
                    child: Column(
                      children: [
                        Slider(
                          value: _age.toDouble(),
                          min: 15,
                          max: 80,
                          divisions: 65,
                          label: _age.toString(),
                          onChanged: (value) {
                            setState(() {
                              _age = value.round();
                            });
                          },
                          onChangeEnd: (value) {
                            _updateMetrics();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('15', style: Theme.of(context).textTheme.bodySmall),
                            Text('80', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMetricCard(
                    title: 'Weight',
                    value: UnitConverter.getDisplayWeight(_weight, _weightUnit == WeightUnit.kg).toStringAsFixed(1),
                    unit: _weightUnit == WeightUnit.kg ? 'kg' : 'lbs',
                    icon: Icons.monitor_weight,
                    gradient: const [Color(0xFFFF6584), Color(0xFFFF8A9B)],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChoiceChip(
                              label: const Text('kg'),
                              selected: _weightUnit == WeightUnit.kg,
                              onSelected: (selected) {
                                setState(() {
                                  _weightUnit = WeightUnit.kg;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: const Text('lbs'),
                              selected: _weightUnit == WeightUnit.lbs,
                              onSelected: (selected) {
                                setState(() {
                                  _weightUnit = WeightUnit.lbs;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: _weight,
                          min: 40,
                          max: 150,
                          divisions: 220,
                          label: '${UnitConverter.getDisplayWeight(_weight, _weightUnit == WeightUnit.kg).toStringAsFixed(1)} ${_weightUnit == WeightUnit.kg ? 'kg' : 'lbs'}',
                          onChanged: (value) {
                            setState(() {
                              _weight = value;
                            });
                          },
                          onChangeEnd: (value) {
                            _updateMetrics();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_weightUnit == WeightUnit.kg ? '40 kg' : '88 lbs',
                                style: Theme.of(context).textTheme.bodySmall),
                            Text(_weightUnit == WeightUnit.kg ? '150 kg' : '330 lbs',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMetricCard(
                    title: 'Height',
                    value: UnitConverter.getDisplayHeight(_height, _heightUnit == HeightUnit.cm).toStringAsFixed(_heightUnit == HeightUnit.cm ? 0 : 1),
                    unit: _heightUnit == HeightUnit.cm ? 'cm' : 'in',
                    icon: Icons.height,
                    gradient: const [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ChoiceChip(
                              label: const Text('cm'),
                              selected: _heightUnit == HeightUnit.cm,
                              onSelected: (selected) {
                                setState(() {
                                  _heightUnit = HeightUnit.cm;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: const Text('in'),
                              selected: _heightUnit == HeightUnit.inches,
                              onSelected: (selected) {
                                setState(() {
                                  _heightUnit = HeightUnit.inches;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: _height,
                          min: 140,
                          max: 220,
                          divisions: 80,
                          label: '${UnitConverter.getDisplayHeight(_height, _heightUnit == HeightUnit.cm).toStringAsFixed(_heightUnit == HeightUnit.cm ? 0 : 1)} ${_heightUnit == HeightUnit.cm ? 'cm' : 'in'}',
                          onChanged: (value) {
                            setState(() {
                              _height = value;
                            });
                          },
                          onChangeEnd: (value) {
                            _updateMetrics();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_heightUnit == HeightUnit.cm ? '140 cm' : '55 in',
                                style: Theme.of(context).textTheme.bodySmall),
                            Text(_heightUnit == HeightUnit.cm ? '220 cm' : '87 in',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_bmi != null)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.analytics,
                                color: Theme.of(context).colorScheme.primary,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Your BMI',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _bmi!.toStringAsFixed(1),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'kg/m²',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _bmiCategory,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required List<Color> gradient,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          value,
                          style:
                              Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            unit,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
